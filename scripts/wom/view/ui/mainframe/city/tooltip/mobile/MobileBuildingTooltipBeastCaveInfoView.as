package wom.view.ui.mainframe.city.tooltip.mobile
{
   import peak.i18n.PText;
   import starling.display.Sprite;
   import wom.model.game.beast.BeastInfo;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   
   public class MobileBuildingTooltipBeastCaveInfoView extends Sprite
   {
      
      private var _spyMood:Boolean;
      
      private var infoTextField:MobileWomTextField;
      
      private var _beastInfo:BeastInfo;
      
      public function MobileBuildingTooltipBeastCaveInfoView(param1:Boolean = false)
      {
         super();
         _spyMood = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         infoTextField = new MobileWomTextField();
         infoTextField.textRendererProperties.textFormat = getWomTextFormat(23);
         addChild(infoTextField);
      }
      
      public function updateBeastInfo(param1:BeastInfo) : void
      {
         _beastInfo = param1;
         var _temp_3:*;
         var _temp_2:*;
         var _loc2_:String;
         var _loc3_:int;
         var _loc4_:*;
         var _loc5_:String;
         var _loc6_:String;
         infoTextField.text = _beastInfo ? (_temp_3 = "ui.mainframe.city.tooltip.beastlevel",_loc2_ = "domain.beasts." + param1.typeId + ".name",_temp_2 = peak.i18n.PText.INSTANCE.getText0(_loc2_),_loc3_ = param1.level,_loc4_ = _temp_2,_loc5_ = _temp_3,peak.i18n.PText.INSTANCE.getText2(_loc5_,_loc4_,_loc3_)) : (_loc6_ = "ui.popups.actionnotpossible.type.96",peak.i18n.PText.INSTANCE.getText0(_loc6_));
      }
      
      public function get beastInfo() : BeastInfo
      {
         return _beastInfo;
      }
   }
}

