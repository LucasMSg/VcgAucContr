pragma solidity ^0.4.4;

contract Auction {

  CustomMap balances;
  
  CustomMap4Bidders bidmap;

  struct CustomMap {
     mapping (uint => address) maps;
     uint256[] keys;
  }
  
  struct CustomMap4Bidders {
      mapping (uint256 => address) maps;
      uint256[] bids;
  }
  
  struct CustomMap4Bids {
      mapping (uint => address) maps;
      uint[] keys;
  }
  
  //declaration of event for debugging
  event itemCast(uint256 item);
  
  function Auction(/*uint256[] item4Auch*/) {
      balances.keys = [1,2,3];//item4Auch;
      uint arrayLength = balances.keys.length;
      
      for (uint i=0; i<arrayLength; i++) {
          itemCast(balances.keys[i]);
        balances.maps[balances.keys[i]] = address(this);
        }
    // constructor, executed once during the creation of the contract
    //address(this)
    
  }

  function simpleChangeOfOwner(uint256 itemC, address bidder) payable  {
      balances.maps[itemC] = bidder; //0x0000000000000000000000000000000000000000
  }
  
  
  
  //[10, 5, 12, 1]  
  //["0x0000000000000000000000000000000000000000", "0x1111111111111111111111111111111111111111", "0x1222211111111111111111111111111111111111", "0x4444411111111111111111111111111111111111"]
  //["0x0000000000000000000000000000000000000000", "0x1111111111111111111111111111111111111111", "0x1222211111111111111111111111111111111111", "0x4444411111111111111111111111111111111111"], [10, 5, 12, 1]
  
  function simpleAuction(address[] addressBid ,uint256[] values) payable returns (uint256[]){
     
     
     //use bidmap here!!
     
     /*first buid a map with bids and bidders*/
     //couldnt make this a memory
     //https://ethereum.stackexchange.com/questions/25282/why-conceptually-cant-mappings-be-local-variables 
     //bids.bids = values;
     //Could create separeted functions for this, but maybe we'll need to write on storage  
     uint256 arrayLength = values.length;
     
     //creating an array for the winners
     address[] winners; //cannot be a memory, or we cant use push
     
     
     for (uint i=0; i<arrayLength; i++) {
        bidmap.maps[values[i]] = addressBid[i];
        }
    //construct the map

    //quick sort the map
    quickSort(values, int(0), int(arrayLength - 1));
    bidmap.bids = values;
    
    uint256 itemsLenght = balances.keys.length;
    
    for (uint j = (itemsLenght); j > 0; j-- ) {
     winners.push(bidmap.maps[values[j]]);   
    }
    
    updateWinners(winners);
    setPrices();
    //return (bidmap.bids);
  }
  
  
  
  function updateWinners(address[] winners) payable returns(uint256){
      
      uint256 itemsLenght = winners.length;
      
      for(uint i = 0; i < itemsLenght; i++) {
          balances.maps[balances.keys[i]] = winners[(itemsLenght - 1 - i)];
      }
      
  }
  
  
  function setPrices() returns(uint256[]){
      //uint256[] memory prices;
      uint256 length = 3;//winners.length;
      //apparently we can use this to initialize an array from memory
      uint256[] memory prices = new uint256[](length);
      
      //uint8[] memory theArray = new uint8[](12)
      uint256 j = 0;
      for (uint256 i = 0; i < length; i++){
        prices[i] = addUp(bidmap.bids, 1 + j, length);
        j++;
        //bidmap.bids[length - i];
        //n - 1 winners summation
        
      }
      
      return(prices);
  }
 

  function printMap() constant returns (uint256[],address[]){
      uint len = balances.keys.length;
      //uint256[] memory keys = new uint256[](len);
      address[] memory values = new address[](len);
      
      for (uint i = 0 ; i <  len ; i++) {
         uint256 key = balances.keys[i];
         balances.keys[i] = key; //it was keys before
         values[i] = balances.maps[key];
      }
      return (balances.keys /*before it was keys*/,values);
  }
  
    function quickSort(uint[] memory arr, int left, int right) internal{ //O(n^2)
        int i = left;
        int j = right;
        if(i==j) return;
        uint pivot = arr[uint(left + (right - left) / 2)];
        while (i <= j) {
            while (arr[uint(i)] < pivot) i++;
            while (pivot < arr[uint(j)]) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }
    
    function addUp (uint256[] arr, uint256 first, uint256 howMany) internal returns (uint256) {
        uint256  sum;
        
        for (uint i = first; i <= (first + howMany -1 ); i ++) {
            sum = sum + arr[i];
        }
        
        //tem q ter um controle se o array acabou
        
        return sum;
    }

  

}
