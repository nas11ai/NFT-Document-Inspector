// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "./contract_abstracts/Authorize.sol";

contract KtpInspector is Authorize {

    mapping(address => KtpData) public UserToKtpData;
    address[] public ktpOwnerCounter;   

    struct KtpData{
        bool Valid;
        string NIK;
        address NftAddress;
        string Ktp_Uri;
    } 

    // only emit owner and caller
    event KtpAdded(
        address indexed Caller,
        address indexed Owner
    );

    // only emit owner and caller
    event KtpUpdated(
        address indexed Caller,
        address indexed Owner
    );

    event KtpRemoved(
        address indexed Caller,
        address indexed Owner
    );

    function findKtp(address Owner) public view DocumentOwnerOnly(Owner) returns(KtpData memory) {
        KtpData memory ktp;
        for(uint i; i<ktpOwnerCounter.length;i++){
            if(ktpOwnerCounter[i] == Owner){
                ktp = UserToKtpData[ktpOwnerCounter[i]];
                break;
            }
        }
        require(ktp.Valid, "KTP DATA NOT FOUND!!!");
        return ktp;        
    }

    function addKtp (address Owner,address nftKtp, string memory DataNik, string memory Ipfs_Uri) public AdministratorOnly{
        require(isUser(Owner),"Owner not registered yet!");
        require(!UserToKtpData[Owner].Valid,"There's Already KTP Data");
        ktpOwnerCounter.push(Owner);
        KtpData storage newKTP = UserToKtpData[Owner];
        newKTP.NIK = DataNik;
        newKTP.NftAddress = nftKtp;
        newKTP.Ktp_Uri = Ipfs_Uri;
        newKTP.Valid = true;
        emit KtpAdded(msg.sender,Owner);
    }

    function editKtp (address Owner,address nftKtp, string memory DataNik, string memory Ipfs_Uri) public AdministratorOnly{
        require(UserToKtpData[Owner].Valid,"KTP not found"); 
        UserToKtpData[Owner].NIK = DataNik;
        UserToKtpData[Owner].NftAddress = nftKtp;
        UserToKtpData[Owner].Ktp_Uri = Ipfs_Uri;
        emit KtpUpdated(msg.sender,Owner);
    }

    function removeKtp (address Owner) public AdministratorOnly{
        require(UserToKtpData[Owner].Valid,"KTP not found"); 
        delete UserToKtpData[Owner]; 
        emit KtpRemoved(msg.sender,Owner);
    }
}
