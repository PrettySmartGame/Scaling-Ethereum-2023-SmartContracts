pragma solidity ^0.8.0;

contract OrganizationUserManagement {
    address public admin;
    uint256 public userCount;

    struct User {
        uint256 id;
        address account;
        string name;
        string role;
    }

    mapping(address => User) public users;
    mapping(uint256 => address) public userIds;

    event UserRegistered(uint256 id, address account, string name, string role);
    event UserRoleUpdated(uint256 id, string newRole);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registerUser(address _account, string memory _name, string memory _role) public onlyAdmin {
        require(_account != address(0), "Invalid account address.");
        require(bytes(_name).length > 0, "User name cannot be empty.");
        require(bytes(_role).length > 0, "User role cannot be empty.");
        require(users[_account].id == 0, "User already registered.");

        userCount++;
        users[_account] = User(userCount, _account, _name, _role);
        userIds[userCount] = _account;

        emit UserRegistered(userCount, _account, _name, _role);
    }

    function updateUserRole(uint256 _id, string memory _newRole) public onlyAdmin {
        require(_id > 0 && _id <= userCount, "Invalid user ID.");
        require(bytes(_newRole).length > 0, "User role cannot be empty.");

        address _account = userIds[_id];
        User storage user = users[_account];
        user.role = _newRole;

        emit UserRoleUpdated(_id, _newRole);
    }

    function deleteUser(uint256 _id) public onlyAdmin {
        require(_id > 0 && _id <= userCount, "Invalid user ID.");

        address _account = userIds[_id];
        delete users[_account];
        delete userIds[_id];

        userCount--;
    }
}
