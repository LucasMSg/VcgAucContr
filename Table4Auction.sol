pragma solidity ^0.4.4;

contract Table4Auction {

  CustomMap balances;
  
  CustomMap4Bidders bidmap;

  struct CustomMap {
     mapping (uint => address) maps;
     uint256[] keys;
  }
  
  struct CustomMap4Bidders {
      mapping (address => uint) maps;
      address[] biddersAddresses;
  }
  
  struct Bids {
      address bidder;
      uint256 valueBid;
  }
  
  struct CustomMap4Bids {
      mapping (uint => address) maps;
      uint[] keys;
  }
  
  //declaration of event for debugging
  event itemCast(uint256 item);
  
  function Table4Auction(/*uint256[] item4Auch*/) {
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
  
  function simpleAuctionPrototype() payable returns (address, address, address){
      //input an array of bidders and bids 
      //[adress, uint][] memory bids = [[0x0000000000000000000000000000000000000000, 10], [0x1111111111111111111111111111111111111111, 10]]; 
      
      Bids[4] memory bids;
      uint256[4] memory valueBidArray;
      
      Bids memory firstUser;
      firstUser.bidder = 0x0000000000000000000000000000000000000000;
      firstUser.valueBid = 10;
      
      Bids memory secondUser;
      secondUser.bidder = 0x1111111111111111111111111111111111111111;
      secondUser.valueBid = 5;
      
      Bids memory thirdUser;
      thirdUser.bidder = 0x1222211111111111111111111111111111111111;
      thirdUser.valueBid = 2;
      
      Bids memory fourthUser;
      fourthUser.bidder = 0x4444411111111111111111111111111111111111;
      fourthUser.valueBid = 1;
      
      bids[0] = firstUser;
      bids[1] = secondUser;
      bids[2] = thirdUser;
      bids[3] = fourthUser;
      
      valueBidArray[0] = firstUser.valueBid;
      valueBidArray[1] = secondUser.valueBid;
      valueBidArray[2] = thirdUser.valueBid;
      valueBidArray[3] = fourthUser.valueBid; 
      
      
      //let's consider all items desirables, lower index, more desirable for user 
      //check how many n items
      uint len = balances.keys.length;
      //then search for n highest bidders 
      //change map
      
      //this was working!
      //quickSort(valueBidArray, int(0), int(3));
      //balances.maps[1] = bids[1].bidder;
      //return (valueBidArray);
      
      
      //everything new here
      CustomMap4Bids bidmap;
      //mapping (uint => address) maps;
      //uint[] keys;
      bidmap.keys = valueBidArray;
      
      uint arrayLength = bidmap.keys.length;
      
      for (uint i=0; i<arrayLength; i++) {
        bidmap.maps[bidmap.keys[i]] = bids[i].bidder;
        }
        
      quickSort(valueBidArray, int(0), int(3));
      
      return (bidmap.maps[valueBidArray[3]], bidmap.maps[valueBidArray[2]], bidmap.maps[valueBidArray[1]]);
  
      /*address[] winners;
      uint max = balances.keys.length;
      
      for (uint j=balances.keys.length; j>0; j--){
          winners[(max - j)] = bidmap.maps[valueBidArray[j]];
      }
      
      return(winners);*/
      
      
  }
  
  /*function simpleAuction(uint256[] userBids) payable{
      
      //maybe use a map key values
      //lets suppose a set number of participants 
      //0x0000000000000000000000000000000000000000
      //0x1111111111111111111111111111111111111111
      //0x2222222222222222222222222222222222222222
      //0x3333333333333333333333333333333333333333
      
      //we receive an array of values bidded by participants and map them to the addresses
      
      bidmap.biddersAddresses = [0x0000000000000000000000000000000000000000,0x1111111111111111111111111111111111111111,0x2222222222222222222222222222222222222222,0x3333333333333333333333333333333333333333];
      uint arrayLength = bidmap.biddersAddresses.length;
      
      for (uint i=0; i<arrayLength; i++) {
        bidmap.maps[bidmap.biddersAddresses[i]] = userBids[i];
        }
        
       // quickSort(valueBidArray, int(0), int(3));
      
    
  }*/
  
 

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
  
  

  //function sort(uint[] data) public constant returns(uint[]) {
    //   quickSort(data, int(0), int(data.length - 1));
    //   return data;
    //}
    
    function quickSort(uint[4] memory arr, int left, int right) internal{ //O(n^2)
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

  

}
