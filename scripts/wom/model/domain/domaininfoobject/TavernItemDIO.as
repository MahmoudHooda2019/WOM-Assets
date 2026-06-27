package wom.model.domain.domaininfoobject
{
   public class TavernItemDIO
   {
      
      private var _id:int;
      
      private var _assetName:String;
      
      private var _visualOrder:int;
      
      private var _unlockCardIndex:int;
      
      private var _scale:Number;
      
      public function TavernItemDIO(param1:int, param2:String, param3:int, param4:int = -1, param5:Number = 1)
      {
         super();
         _id = param1;
         _assetName = param2;
         _visualOrder = param3;
         _unlockCardIndex = param4;
         this._scale = param5;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get visualOrder() : int
      {
         return _visualOrder;
      }
      
      public function get unlockCardIndex() : int
      {
         return _unlockCardIndex;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
   }
}

