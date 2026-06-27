package peak.component.mobile
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import feathers.controls.Label;
   import wom.view.component.WomTextFormats;
   
   public class MPTextField extends Label
   {
      
      private var _flarabyAS3:FlarabyAS3;
      
      private var _flarabyAS3Data:String;
      
      public function MPTextField()
      {
         super();
         this.textRendererProperties.textFormat = WomTextFormats.WOM_DEFAULT;
         this.textRendererProperties.embedFonts = true;
         this.textRendererProperties.antiAliasType = "advanced";
         this.textRendererProperties.smoothing = "trilinear";
      }
      
      override public function set text(param1:String) : void
      {
         super.text = param1;
         validate();
      }
   }
}

