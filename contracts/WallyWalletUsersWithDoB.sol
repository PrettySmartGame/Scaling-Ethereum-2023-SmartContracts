// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WallyWalletUsersWithDoB {
    
    struct User {
        string name;
        string email;
        address walletAddress;
        uint256 paintLevel;
        uint256 memoryLevel;
        string dob;
        bool exists;
    }

    mapping(address => User) private users;

    function registerUser(
        string memory _name,
        string memory _email,
        address _walletAddress,
        uint256 _paintLevel,
        uint256 _memoryLevel,
        string memory _dob
    ) public {
        require(!users[_walletAddress].exists, "User already exists.");
        users[_walletAddress] = User({
            name: _name,
            email: _email,
            walletAddress: _walletAddress,
            paintLevel: _paintLevel,
            memoryLevel: _memoryLevel,
            dob: _dob,
            exists: true
        });
    }

    function doesUserExist(address _walletAddress) public view returns (bool) {
        return users[_walletAddress].exists;
    }

    function updateUser(
        address _walletAddress,
        string memory _newName,
        string memory _newEmail,
        uint256 _paintLevel,
        uint256 _memoryLevel,
        string memory _newDob
    ) public {
        require(users[_walletAddress].exists, "User does not exist.");
        users[_walletAddress].name = _newName;
        users[_walletAddress].email = _newEmail;
        users[_walletAddress].paintLevel = _paintLevel;
        users[_walletAddress].memoryLevel = _memoryLevel;
        users[_walletAddress].dob = _newDob;
    }

    function updateUserPaintlevel(
        address _walletAddress,
        uint256 _paintLevel
    ) public {
        require(users[_walletAddress].exists, "User does not exist.");
        users[_walletAddress].paintLevel = _paintLevel;
    }

    function updateUserMemoryLevel(
        address _walletAddress,
        uint256 _memoryLevel
    ) public {
        require(users[_walletAddress].exists, "User does not exist.");
        users[_walletAddress].memoryLevel = _memoryLevel;
    }

    function deleteUser(address _walletAddress) public {
        require(users[_walletAddress].exists, "User does not exist.");
        delete users[_walletAddress];
    }

    function getUserInfo(address _walletAddress)
        public
        view
        returns (
            string memory name,
            string memory email,
            uint256 paintLevel,
            uint256 memoryLevel,
            string memory dob
        )
    {
        require(users[_walletAddress].exists, "User does not exist.");
        User memory user = users[_walletAddress];
        return (user.name, user.email, user.paintLevel, user.memoryLevel, user.dob);
    }

}
