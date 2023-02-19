// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract PresentFinder {
    /*enum Category {
        SPORTS,
        BOOKS,
        HANDMADE,
        DECORATIVE,
        GAMES,
        FOOD,
        STATIONERY,
        MUSIC,
        HOUSEHOLD,
        OTHER
    }*/

    struct Present {
        string name;
        string desc;
        string link;
        string photo;
        string category;
        uint age;
        uint gender;
        uint price; 
        uint rating;
        uint numRevs;
        uint id; 
        address gifter;
    }
    struct Review {
        uint rating;
        string review;
        address reviewer;
    }
    mapping (uint => Present) public idToPresent;
    mapping (uint => Review[]) public idToReviews;
    mapping (address=> uint[]) public personToId;
    mapping (string=>bool) public categoryCheck;
    string [] public categories;
    //Present[] public presents;
    uint public startId = 1;

    function addPresent (
        string memory _name,
        string memory _desc,
        string memory _link,
        string memory  _photo,
        string memory _category,
        uint _age,
        uint _gender,
        uint _price
        
    ) public{
        if(categoryCheck[_category]==false){
            categories.push(_category);
            categoryCheck[_category]=true;
        }
        Present memory pres = Present (
            _name,
            _desc,
            _link,
            _photo,
            _category,
            _age,
            _gender,
            _price, 
            0,
            0,
            startId, 
            msg.sender
        );
        idToPresent[startId] = pres;
        //presents.push (pres);
        personToId[msg.sender].push(startId);
        startId++;
    }

    function review (
        uint _id,
        uint _rating,
        string memory _rev
    )
    public {
        require (msg.sender != idToPresent[_id].gifter, "Gifter cannot add review");
        Review [] memory revArr = idToReviews[_id];
        bool revd = false;
        for (uint i = 0; i<revArr.length; i++){
            if (revArr[i].reviewer == msg.sender){
                revd = true;
            }
        }
        require(revd == false, "Cannot review twice");
        uint presRate = idToPresent[_id].rating;
        _updateRating(_id, presRate, _rating, revArr.length);
        idToReviews[_id].push(Review (_rating, _rev, msg.sender));
        idToPresent[_id].numRevs++;
    }

    function _updateRating (uint _id, uint _prevRate, uint _newRate, uint _reviews)internal {
        uint newRate = ((_prevRate * _reviews) + _newRate) / (_reviews+1);
        idToPresent[_id].rating = newRate;
    }

    function getPresents  (uint _lowAge, uint _highAge, string memory _category, uint _highestPrice, uint _rating,uint _gender) view public returns (uint[] memory presIds){
        uint retCount = 0;
        for (uint i =1 ; i<= startId;i++ ) {
            Present memory pr = idToPresent[i];
            if (pr.gender == _gender && keccak256(bytes(pr.category)) == keccak256(bytes(_category)) && pr.age >= _lowAge && pr.age <= _highAge && pr.price<= _highestPrice && pr.rating >= _rating){
                retCount++;
            }
        }
        uint[] memory filtIds = new uint[](retCount);
        uint j=0;
        for (uint i =1 ; i<= startId;i++ ) {
            Present memory pr = idToPresent[i];
            if (pr.gender == _gender && keccak256(bytes(pr.category)) == keccak256(bytes(_category)) && pr.age >= _lowAge && pr.age <= _highAge && pr.price<= _highestPrice && pr.rating >= _rating){
                filtIds[j]=(pr.id);
                j++;
   
            }
        }
        return filtIds;
    }
}