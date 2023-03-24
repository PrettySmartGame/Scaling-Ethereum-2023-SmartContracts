// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WallyWalletUsersWithDoB {
    struct User {
        string name;
        string email;
        address walletAddress;
        uint256 type1;
        uint256 type2;
        string dob;
        bool exists;
    }

    mapping(address => User) private users;

    function registerUser(
        string memory _name,
        string memory _email,
        address _walletAddress,
        uint256 _type1,
        uint256 _type2,
        string memory _dob
    ) public {
        require(!users[_walletAddress].exists, "User already exists.");
        users[_walletAddress] = User({
            name: _name,
            email: _email,
            walletAddress: _walletAddress,
            type1: _type1,
            type2: _type2,
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
        uint256 _newType1,
        uint256 _newType2,
        string memory _newDob
    ) public {
        require(users[_walletAddress].exists, "User does not exist.");
        users[_walletAddress].name = _newName;
        users[_walletAddress].email = _newEmail;
        users[_walletAddress].type1 = _newType1;
        users[_walletAddress].type2 = _newType2;
        users[_walletAddress].dob = _newDob;
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
            uint256 type1,
            uint256 type2,
            string memory dob
        )
    {
        require(users[_walletAddress].exists, "User does not exist.");
        User memory user = users[_walletAddress];
        return (user.name, user.email, user.type1, user.type2, user.dob);
    }
}
