pragma solidity 0.5.12;

contract HelloWorld2{
    
    struct Person{
        string name;
        uint age;
        uint height;
        bool senior;
    }
    
    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);
    event personUpdated(string oldName, uint oldAge, uint oldHeight, bool oldSenior, string newName, uint newAge, uint newHeight, bool newSenior);
    
    address public owner;
    
    modifier onlyOwner(){
     require(msg.sender == owner);
     _;
    }
    
    constructor() public{
        owner = msg.sender;
    }
    
    mapping(address => Person) private people;
    address[] private creators;
    

    function updateOrCreatePeople(string memory name, uint age, uint height) public{
        if(people[msg.sender].age == 0 ){
            createPerson(name, age, height);
            creators.push(msg.sender);
            emit personCreated(people[msg.sender].name, people[msg.sender].senior);
        }else {
            string memory oldName = people[msg.sender].name;
            uint oldAge = people[msg.sender].age;
            uint oldHeight = people[msg.sender].height;
            bool oldSenior = people[msg.sender].senior;
            createPerson(name, age, height);
            emit personUpdated(oldName, oldAge, oldHeight, oldSenior, name, age, height, people[msg.sender].senior);
        }
        
    }

    function createPerson(string memory name, uint age, uint height) public{
         require(age<150, "Age needs to be below 150");
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;
        if(age>= 65){
            newPerson.senior = true;
        }
        else{
            newPerson.senior = false;
        }
        
        insertPerson(newPerson);
        assert(
            keccak256(
                abi.encodePacked(
                    people[msg.sender].name,
                    people[msg.sender].age,
                    people[msg.sender].height,
                    people[msg.sender].senior
                    )
                )==
                keccak256(
                    abi.encodePacked(
                        newPerson.name,
                        newPerson.age,
                        newPerson.height,
                        newPerson.senior
                        )
                    )
                );
    }
    
    function insertPerson(Person memory newPerson) private {
        address creator = msg.sender;
        people[creator] = newPerson;
    }
    
    function getPerson() public view returns (string memory, uint, uint, bool){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    
    function deletePerson(address creator) public onlyOwner{
        string memory name = people[creator].name;
        bool senior = people[creator].senior;
        
        delete people[creator];
        assert(people[creator].age == 0);
        emit personDeleted(name, senior, msg.sender);
    }
    
    function getCreator(uint index) public view onlyOwner returns (address){
        return creators[index];
    }
    
}