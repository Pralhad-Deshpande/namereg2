contract Bank is NameRegEnabled {
/*
    address owner;

    function NameRegEnabled(){
	owner = msg.sender;
    }

    function setPermission(address addr, uint8 permLvl) returns (bool res){
	if (msg.sender != owner){
	    return false;
	}
	address permsdb = ContractProvider(NAMEREG).contracts("permsdb");
	if(permsdb == 0x0){
	    return false;
	}
	return PermissionDb(permsdb).setPermission(addr, permLvl);

    }
*/
}

contract PermissionsDb is NameRegEnabled{
 /*   function setPermission(address addr, uint8 permLvl) returns (bool res){
	return true;
    }
*/
}

contract DepositsDb is NameRegEnabled{

}

contract CreditsDb is NameRegEnabled{

}

contract LCDb is NameRegEnabled{

}
