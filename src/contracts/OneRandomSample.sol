pragma solidity ^0.5.0;

contract OneRandomSample {
  string public name;
  uint public pollIdCounter = 0;
  mapping(uint => Poll) public polls;

  struct Poll {
    uint id;
    string question;
    string option1;
    string option2;
    string option3;
    uint prizePot;
    uint endTime;
    address author;
  }

  constructor() public {
    name = "one random sample contract";
  }

  function createPoll
    (
      string memory _question,
      string memory _option1,
      string memory _option2,
      string memory _option3,
      uint _prizePot,
      uint _endTime
    )
    public {
      pollIdCounter++;
      polls[pollIdCounter] = Poll(pollIdCounter, _question, _option1, _option2, _option3, _prizePot, _endTime, msg.sender);
    }
}