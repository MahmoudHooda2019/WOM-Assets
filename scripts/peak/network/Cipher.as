package peak.network
{
   import flash.utils.ByteArray;
   
   public interface Cipher
   {
      
      function encodeBytes(param1:ByteArray) : ByteArray;
      
      function encodeByte(param1:uint) : uint;
      
      function decodeBytes(param1:ByteArray) : ByteArray;
      
      function decodeByte(param1:uint) : uint;
      
      function resetCipher() : void;
   }
}

