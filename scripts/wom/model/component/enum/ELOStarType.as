package wom.model.component.enum
{
   public class ELOStarType
   {
      
      public static const EMPTY:ELOStarType = new ELOStarType(0,"ELOEmpty","EloIconEmpty","IconBPDisable","ELONotr");
      
      public static const NEGATIVE:ELOStarType = new ELOStarType(1,"ELONegative","EloIconBad","IconBPDisable","ELONotr");
      
      public static const POSITIVE:ELOStarType = new ELOStarType(2,"ELOPositive","EloIconGood","IconBP","ELOPositive");
      
      private var _id:int;
      
      private var _smallAssetName:String;
      
      private var _bigAssetName:String;
      
      private var _mobileSmallAssetName:String;
      
      private var _mobileBigAssetName:String;
      
      public function ELOStarType(param1:int, param2:String, param3:String, param4:String, param5:String)
      {
         super();
         _id = param1;
         _smallAssetName = param2;
         _bigAssetName = param3;
         _mobileSmallAssetName = param4;
         _mobileBigAssetName = param5;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get smallAssetName() : String
      {
         return _smallAssetName;
      }
      
      public function get bigAssetName() : String
      {
         return _bigAssetName;
      }
      
      public function get mobileSmallAssetName() : String
      {
         return _mobileSmallAssetName;
      }
      
      public function get mobileBigAssetName() : String
      {
         return _mobileBigAssetName;
      }
   }
}

