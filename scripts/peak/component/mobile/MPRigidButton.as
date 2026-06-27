package peak.component.mobile
{
   import starling.display.DisplayObject;
   
   public class MPRigidButton extends MPButton
   {
      
      private var _normalSkinId:String;
      
      private var _tapSkinId:String;
      
      private var _isRemoteAsset:Boolean;
      
      public function MPRigidButton(param1:String, param2:String, param3:Boolean = false)
      {
         _normalSkinId = param1;
         _tapSkinId = param2;
         _isRemoteAsset = param3;
         super();
         this.useHandCursor = true;
         setPaddings(10,10,10,10);
      }
      
      override protected function refreshSkin() : void
      {
         super.refreshSkin();
         if(currentSkin)
         {
            this.width = currentSkin.width;
            this.height = currentSkin.height;
         }
         else if(defaultSkin)
         {
            this.width = defaultSkin.width;
            this.height = defaultSkin.height;
         }
      }
      
      override public function get height() : Number
      {
         return currentSkin ? currentSkin.height : (defaultSkin ? defaultSkin.height : super.height);
      }
      
      override protected function positionSingleChild(param1:DisplayObject) : void
      {
         super.positionSingleChild(param1);
         param1.y += _currentState == "down" ? 3 : 0;
      }
      
      public function get normalSkinId() : String
      {
         return _normalSkinId;
      }
      
      public function get tapSkinId() : String
      {
         return _tapSkinId;
      }
      
      public function get isRemoteAsset() : Boolean
      {
         return _isRemoteAsset;
      }
      
      override public function get width() : Number
      {
         return currentSkin ? currentSkin.width : (defaultSkin ? defaultSkin.width : super.width);
      }
   }
}

