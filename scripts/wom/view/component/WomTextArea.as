package wom.view.component
{
   import flash.text.TextField;
   import peak.component.PTextArea;
   
   public class WomTextArea extends PTextArea
   {
      
      public function WomTextArea()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         isLivePreview = checkLivePreview();
         var _loc2_:Number = rotation;
         rotation = 0;
         var _loc1_:Number = super.width;
         var _loc3_:Number = super.height;
         super.scaleX = super.scaleY = 1;
         setSize(_loc1_,_loc3_);
         move(super.x,super.y);
         rotation = _loc2_;
         startWidth = _loc1_;
         startHeight = _loc3_;
         if(numChildren > 0)
         {
            removeChildAt(0);
         }
         tabChildren = true;
         textField = new TextField();
         textField.defaultTextFormat = WomTextFormats.WOM_DEFAULT;
         addChild(textField);
         updateTextFieldType();
         _verticalScrollBar = new WomScrollBar();
         _verticalScrollBar.width = 20;
         _verticalScrollBar.name = "V";
         _verticalScrollBar.visible = false;
         _verticalScrollBar.focusEnabled = false;
         copyStylesToChild(_verticalScrollBar,SCROLL_BAR_STYLES);
         _verticalScrollBar.addEventListener("scroll",handleScroll,false,0,true);
         addChild(_verticalScrollBar);
         _horizontalScrollBar = new WomScrollBar();
         _horizontalScrollBar.name = "H";
         _horizontalScrollBar.visible = false;
         _horizontalScrollBar.focusEnabled = false;
         _horizontalScrollBar.direction = "horizontal";
         copyStylesToChild(_horizontalScrollBar,SCROLL_BAR_STYLES);
         _horizontalScrollBar.addEventListener("scroll",handleScroll,false,0,true);
         addChild(_horizontalScrollBar);
         textField.addEventListener("textInput",handleTextInput,false,0,true);
         textField.addEventListener("change",handleChange,false,0,true);
         textField.addEventListener("keyDown",handleKeyDown,false,0,true);
         _horizontalScrollBar.scrollTarget = textField;
         _verticalScrollBar.scrollTarget = textField;
         addEventListener("mouseWheel",handleWheel,false,0,true);
      }
   }
}

