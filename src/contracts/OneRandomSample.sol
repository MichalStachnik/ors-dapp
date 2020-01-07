pragma solidity ^0.5.0;

contract OneRandomSample {
  string public name;
  uint public pollIdCounter = 0;
  mapping(uint => Poll) polls;

  struct Poll {
    uint id;
    string question;
    // mapping(uint => Option) options;
    // Option[] options;
    Option option1;
    Option option2;
    Option option3;
    uint prizePot;
    uint endTime;
    address author;
    // mapping(uint => address) contributors;
    address[] voters;
    uint voteIdCounter;
  }

  struct Option {
    uint optionId;
    string question;
    uint voteCount;
  }

  constructor() public {
    name = "one random sample contract";
  }

  function createPoll
    (
      string memory _question,
      string memory _option1Param,
      string memory _option2Param,
      string memory _option3Param
    )
    public payable {
      // If true function will continue
      // checking for existance of question and option
      require(bytes(_question).length > 0, "question required");
      require(bytes(_option1Param).length > 0, "option 1 required");
      require(bytes(_option2Param).length > 0, "option 2 required");
      require(bytes(_option3Param).length > 0, "option 3 required");

      pollIdCounter++;
      address[] memory _voters;
      // mapping(uint => uint) storage _optionsCounter;
      // Option[] memory _options;
      Option memory _option1 = Option(0, _option1Param, 0);
      Option memory _option2 = Option(1,_option2Param, 0);
      Option memory _option3 = Option(2,_option3Param, 0);
      uint _voteIdCounter = 0;

      // Lock poll creator's money in this contract _prizePot
      uint _prizePot = msg.value;

      // block.timestamp can be manipulated by miners
      // but it does not need to be exact here so usage of now is ok
      uint _endTime = now + 24 hours;

      polls[pollIdCounter] = Poll(pollIdCounter, _question, _option1, _option2, _option3, _prizePot, _endTime, msg.sender, _voters, _voteIdCounter);
    }

  // TODO: add modifier to check time
  function sendVote(uint _pollId, uint _selectedOption) public {
    // Get the selected poll
    Poll memory _poll = polls[_pollId];
    // Get the optionsCounter of the poll and add one vote
    if (_selectedOption == 1) {
      _poll.option1.voteCount++;
    } else if (_selectedOption == 2) {
      _poll.option2.voteCount++;
    } else if(_selectedOption == 3) {
      _poll.option3.voteCount++;
    }
    // _poll.options[_selectedOption].voteCount++;

    // Add function caller to address array for poll
    _poll.voters[_poll.voteIdCounter] = msg.sender;

    // Increment the counter
    _poll.voteIdCounter++;

    // Update the poll
    polls[_pollId] = _poll;
  }
}