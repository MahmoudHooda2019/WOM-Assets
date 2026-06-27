package wom.view.screen.popups.unit
{
   import peak.i18n.PText;
   import wom.model.game.resource.ResourceType;
   
   public class NotEnoughResourcePopUp extends GenericNotEnoughPopUp
   {
      
      private var _resourceType:ResourceType;
      
      public function NotEnoughResourcePopUp(param1:int, param2:ResourceType)
      {
         super(param1);
         _resourceType = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         switch(_resourceType)
         {
            case ResourceType.UNKNOWN:
               var _loc1_:String = "ui.popups.notenough.resource.header";
               setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
               var _temp_2:* = speechBubble;
               var _loc2_:String = "ui.popups.notenough.resource.desc";
               _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
               var _temp_3:* = _okButton;
               var _loc3_:String = "ui.popups.notenough.resource.ok";
               _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               break;
            case ResourceType.IRON:
               var _loc4_:String = "ui.popups.notenough.iron.header";
               setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
               var _temp_5:* = speechBubble;
               var _loc5_:String = "ui.popups.notenough.iron.desc";
               _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               var _temp_6:* = _okButton;
               var _loc6_:String = "ui.popups.notenough.iron.ok";
               _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
               break;
            case ResourceType.MIGHT:
               var _loc7_:String = "ui.popups.notenough.might.header";
               setHeader(peak.i18n.PText.INSTANCE.getText0(_loc7_));
               var _temp_8:* = speechBubble;
               var _loc8_:String = "ui.popups.notenough.might.desc";
               _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
               var _temp_9:* = _okButton;
               var _loc9_:String = "ui.popups.notenough.might.ok";
               _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         }
         _okButton.width = 200;
         drawLayout();
      }
      
      public function get resourceType() : ResourceType
      {
         return _resourceType;
      }
   }
}

