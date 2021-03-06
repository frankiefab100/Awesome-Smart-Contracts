// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Certificate Proof of Existence Contract
 * @dev This PoE stores University Certificate document with time stamp as Hash values.
        The unique identifiers of the certificates are stored on the Ethereum Blockchain.
        It is publicly verifiable to prove their existence.

 * @author Franklin Ohaegbulam (@Frankiefab100)
 */

contract ProofOfExistence {
    address admin;

    constructor(address _admin) {
        admin = _admin;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Insufficient access");
        _;
    }

    struct CertificateDetails {
        uint256 certificateID;
        string candidateName;
        string courseName;
        string grade;
        uint256 date;
    }

    uint256 certificateID = 200;

    mapping(address => uint256) getID;
    mapping(uint256 => CertificateDetails) storeID;

    CertificateDetails[] certificateRecord;

    function proofCertificateExist(
        address _candidate,
        uint256 _certificateID,
        string memory _candidateName,
        string memory _courseName,
        string memory _grade,
        uint256 _date
    ) public onlyAdmin returns (bool, uint256) {
        if (certificateIdTaken(_candidate)) {
            return (false, getID[_candidate]);
        }
        certificateID = certificateID + 1;

        CertificateDetails memory newCertificate = CertificateDetails(
            _certificateID,
            _candidateName,
            _courseName,
            _grade,
            _date
        );

        certificateRecord.push(newCertificate);

        getID[_candidate] = certificateID;
        storeID[certificateID] = newCertificate;
        return (true, certificateID);
    }

    function verifyId(uint256 _certificateID)
        external
        view
        returns (CertificateDetails memory)
    {
        return storeID[_certificateID];
    }

    function retrieveID() external view returns (bool, uint256) {
        uint256 id = getID[msg.sender];
        if (id == 0) return (false, 0);
        return (true, id);
    }

    function certificateIdTaken(address _candidate)
        internal
        view
        returns (bool)
    {
        return !(getID[_candidate] == 0);
    }
}
