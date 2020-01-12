pragma solidity ^0.5.0;

contract OneRandomSample {
  address public owner;
  string public question;
  address[] public voters;
  Option[] public options;
  uint public totalVotes;
  uint public prizePot;
  uint public endDate;

  struct Option {
    string optionName;
    uint voteCount;
  }

  struct Voter {
    address who;
    uint vote;
  }

  constructor(string memory _question, string memory _option1, string memory _option2) public payable {
    owner = msg.sender;
    prizePot = msg.value;
    endDate = block.timestamp + 24 hours;
    question = _question;
    options.push(Option(_option1, 0));
    options.push(Option(_option2, 0));
  }

  function sendVote(uint voteId) public {
    // Get 
    Option memory _chosenOption = options[voteId];
    // Update
    _chosenOption.voteCount++;
    // Set
    options[voteId] = _chosenOption;

    // Add sender to voters
    voters.push(msg.sender);
  }
}