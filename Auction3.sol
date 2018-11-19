pragma solidity ^0.4.4;

contract Auction3 {

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
  event pricePoitn(uint256 x);

  function Auction3(/*uint256[] item4Auch*/) {
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



  //["0x0000000000000000000000000000000000000000", "0x1111111111111111111111111111111111111111", "0x1222211111111111111111111111111111111111", "0x4444411111111111111111111111111111111111"], [10, 5, 12, 1]
  event arrayBeforeSort(uint256[] arr);
  event arrayAfterSort(uint256[] arr);
  function simpleAuction(address[] addressBid ,uint256[] values) payable returns (uint256[]){

    //address[4] addressBid = ["0x0000000000000000000000000000000000000000", "0x1111111111111111111111111111111111111111", "0x1222211111111111111111111111111111111111", "0x4444411111111111111111111111111111111111"];
    //uint256[4] values = [10, 5, 12, 1];

    uint256 arrayLength = values.length;
    address[] winners;

     for (uint i=0; i<arrayLength; i++) {
        bidmap.maps[values[i]] = addressBid[i];
        }
    //construct the map

    //quick sort the map
    quickSort(values, int(0), int(arrayLength - 1));
    arrayBeforeSort(bidmap.bids);
    bidmap.bids = values;
    arrayAfterSort(bidmap.bids);

    uint256 itemsLenght = balances.keys.length;

        for (uint j = (itemsLenght); j > 0; j-- ) {
            winners.push(bidmap.maps[values[j]]);
        }

    arrayAfterSort(bidmap.bids);
    updateWinners(winners);
    setPrices();
  }


  event WinnerAddress (uint256);
  function updateWinners(address[] winners) payable returns(uint256){

      uint256 itemsLenght = winners.length;
      uint256 arrayLength = bidmap.bids.length;

      for(uint i = 0; i < itemsLenght; i++) {
          WinnerAddress(((itemsLenght - 1) - i));
          balances.maps[balances.keys[i]] = winners[i];
      }
  }

 event MemoryBids(uint256[] memoryArr);
  function setPrices() returns(uint256[]){
      //uint256[] memory prices;
      uint256 length = balances.keys.length;//winners.length;
      uint256[] memory prices = new uint256[](length);
      //uint8[] memory theArray = new uint8[](12)
      uint256 j = 0;
      MemoryBids(bidmap.bids);

      uint256 k = bidmap.bids.length;
      uint256 auctionBest = addUp(bidmap.bids , k - 1 - i, length);

      for (uint256 i = 0; i < length; i++){
        prices[i] = addUp(bidmap.bids, k - 1 - i, length);
      }

      return(prices);
  }

 function addUp (uint256[] arr, uint256 me, uint256 howMany) internal returns (uint256) {
        uint256  sum;
        uint256 howManny;

        howManny = howMany;

        for(uint256 j = 0; j < howManny; j++){
            if(j == me){
                howManny ++;
            }
            else{
                sum = sum + arr[j];
            }
        }

        return sum;
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

}
