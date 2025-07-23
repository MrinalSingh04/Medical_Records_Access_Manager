// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MedicalRecordsManager {
    struct Record {
        string ipfsHash;
        uint256 timestamp;
    }

    address public owner;

    mapping(address => Record[]) private patientRecords;
    mapping(address => mapping(address => bool)) public accessPermissions;
    mapping(address => mapping(address => uint256)) public accessExpiry;

    event RecordAdded(address indexed patient, string ipfsHash);
    event AccessGranted(address indexed patient, address indexed doctor, uint256 expiresAt);
    event AccessRevoked(address indexed patient, address indexed doctor);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    modifier onlyPatient(address _patient) {
        require(msg.sender == _patient, "Not authorized as patient");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addRecord(string calldata ipfsHash) external {
        patientRecords[msg.sender].push(Record(ipfsHash, block.timestamp));
        emit RecordAdded(msg.sender, ipfsHash);
    }

    function grantAccess(address doctor, uint256 duration) external {
        accessPermissions[msg.sender][doctor] = true;
        accessExpiry[msg.sender][doctor] = block.timestamp + duration;
        emit AccessGranted(msg.sender, doctor, block.timestamp + duration);
    }

    function revokeAccess(address doctor) external {
        accessPermissions[msg.sender][doctor] = false;
        accessExpiry[msg.sender][doctor] = 0;
        emit AccessRevoked(msg.sender, doctor);
    }

    function getRecords(address patient) external view returns (Record[] memory) {
        require(
            msg.sender == patient ||
            (accessPermissions[patient][msg.sender] && block.timestamp <= accessExpiry[patient][msg.sender]),
            "Access denied"
        );
        return patientRecords[patient];
    }

    function hasAccess(address patient, address viewer) external view returns (bool) {
        return accessPermissions[patient][viewer] && block.timestamp <= accessExpiry[patient][viewer];
    }
}
