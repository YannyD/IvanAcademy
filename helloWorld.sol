pragma solidity 0.5.12;


contract HelloWorld{
    
struct Person{
    address creator;
    uint id;
    string name;
    uint age;
    uint height;
}

Person[] public people;
mapping(address=> uint) creatorCount;
uint[] creatorArray;


function createPerson (string memory name, uint age, uint height) public{
    address sender = msg.sender;
    Person memory newPerson;
    newPerson.creator = sender;
    newPerson.name = name;
    newPerson.age = age;
    newPerson.height = height;
    newPerson.id=(people.length + 1);
    
    people.push(newPerson);
    creatorCount[msg.sender]+=1;
}

function personByIndex (uint index) view public returns (address creator, string memory name, uint id, uint age, uint height){
    return (people[index].creator, people[index].name, people[index].id, people[index].age, people[index].height);
} 

function getCreatorCount(address creator) view public returns(uint){
return creatorCount[creator];
}

function getCreatorArray() public returns(uint[] memory){
    for(uint i=0; i<people.length; i++){
        if(people[i].creator == msg.sender){
            creatorArray.push(people[i].id);
        }
    }
    return (creatorArray);
}

}