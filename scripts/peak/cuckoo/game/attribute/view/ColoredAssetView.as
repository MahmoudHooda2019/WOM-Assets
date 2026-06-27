package peak.cuckoo.game.attribute.view
{
   public class ColoredAssetView extends AssetView
   {
      
      private var _color:uint;
      
      public function ColoredAssetView(param1:int, param2:String, param3:uint = 16777215, param4:Boolean = false)
      {
         super(param1,param2,param4);
         _color = param3;
      }
      
      override public function init() : void
      {
         super.init();
         super.colorFilter(_color);
      }
      
      override public function colorFilter(param1:uint = 16777215) : void
      {
      }
   }
}

