package wom.view.ui.tooltip
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileInformativeTooltipView extends MobileBaseTooltipView
   {
      
      public static const UNDER_PROTECTION:String = "protection";
      
      public static const RECON_POINTS:String = "rp";
      
      private var _type:String;
      
      private var message:MobileCaptionTextField;
      
      public function MobileInformativeTooltipView(param1:String, param2:int, param3:int)
      {
         super(param2,param3,false);
         _type = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.mainframe.city.tooltip." + _type + "header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         message = new MobileCaptionTextField();
         message.width = _bg.width - 58;
         message.textRendererProperties.textFormat = getCaptionTextFormat(25);
         message.textRendererProperties.wordWrap = true;
         addChild(message);
         var _temp_3:* = message;
         var _loc2_:String = "ui.mainframe.city.tooltip." + _type + "message";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleOf(message,_bg);
      }
   }
}

