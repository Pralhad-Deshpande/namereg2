contract NameRegEnabled {
    address NAMEREG;

    function setNameRegAddress(address nameregAddr) returns (bool result){
        // Once the namereg address is set, don't allow it to be set again, except by the
        // namereg contract itself.
        if(NAMEREG != 0x0 && nameregAddr != NAMEREG){
            return false;
        }
        NAMEREG = nameregAddr;
        return true;
    }

    // Makes it so that NameReg is the only contract that may kill it.
    function remove(){
        if(msg.sender == NAMEREG){
            suicide(NAMEREG);
        }
    }

}

// The NameReg contract.
contract NameReg {

    address owner;

    // This is where we keep all the contracts.
    mapping (bytes32 => address) public contracts;

    // Constructor
    function NameReg(){
        owner = msg.sender;
    }

    // Add a new contract to NameReg. This will overwrite an existing contract.
    function addContract(bytes32 name, address addr) returns (bool result) {
        if(msg.sender != owner){
            return;
        }
        NameRegEnabled de = NameRegEnabled(addr);
        // Don't add the contract if this does not work.
        if(!de.setNameRegAddress(address(this))) {
            return false;
        }
        contracts[name] = addr;
        return true;
    }

    function getContract(bytes32 name) constant returns (address addr){
        return contracts[name];
    }

    // Remove a contract from NameReg. We could also suicide if we want to.
    function removeContract(bytes32 name) returns (bool result) {
        if (contracts[name] == 0x0){
            return false;
        }
        if(msg.sender != owner){
            return;
        }
        contracts[name] = 0x0;
        return true;
    }

    function remove(){

        if(msg.sender == owner){

/* Uncommenting this causes trouble	
            address a = contracts["boapermsdb"];
            address b = contracts["boadepositsdb"];
            address c = contracts["boacreditsdb"];
            address d = contracts["boalcdb"];
            address e = contracts["boabank"];

            address f = contracts["bobpermsdb"];
            address g = contracts["bobdepositsdb"];
            address h = contracts["bobcreditsdb"];
            address i = contracts["boblcdb"];
            address j = contracts["bobbank"];


            // Remove everything.
            if(a != 0x0){ NameRegEnabled(a).remove(); }
            if(b != 0x0){ NameRegEnabled(b).remove(); }
            if(c != 0x0){ NameRegEnabled(c).remove(); }
            if(d != 0x0){ NameRegEnabled(d).remove(); }
            if(e != 0x0){ NameRegEnabled(e).remove(); }
            if(f != 0x0){ NameRegEnabled(f).remove(); }
            if(g != 0x0){ NameRegEnabled(g).remove(); }
            if(h != 0x0){ NameRegEnabled(h).remove(); }
            if(i != 0x0){ NameRegEnabled(i).remove(); }
            if(j != 0x0){ NameRegEnabled(j).remove(); }
*/	
            // Finally, remove namereg. NameReg will now have all the funds of the other contracts,
            // and when suiciding it will all go to the owner.
            suicide(owner);
        }
    }

}

// Interface for getting contracts from NameReg
contract ContractProvider {
    function contracts(bytes32 name) returns (address addr) {}
}

contract Dummy{

}

contract Bank is NameRegEnabled {
  bytes32 public bankStr;
  address owner; 

  function Bank (bytes32 a){
    owner = msg.sender;
    bankStr = a;
  }


}

contract PermissionsDb is NameRegEnabled{
}

contract DepositsDb is NameRegEnabled{
}

contract CreditsDb is NameRegEnabled{
} 

contract LCDb is NameRegEnabled{

}

