package feathers.controls
{
   import feathers.controls.supportClasses.LayoutViewPort;
   import feathers.layout.ILayout;
   import feathers.layout.IVirtualLayout;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class ScrollContainer extends Scroller
   {
      
      protected static const INVALIDATION_FLAG_MXML_CONTENT:String = "mxmlContent";
      
      public static const ALTERNATE_NAME_TOOLBAR:String = "feathers-toolbar-scroll-container";
      
      public static const SCROLL_POLICY_AUTO:String = "auto";
      
      public static const SCROLL_POLICY_ON:String = "on";
      
      public static const SCROLL_POLICY_OFF:String = "off";
      
      public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String = "float";
      
      public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String = "fixed";
      
      public static const SCROLL_BAR_DISPLAY_MODE_NONE:String = "none";
      
      public static const INTERACTION_MODE_TOUCH:String = "touch";
      
      public static const INTERACTION_MODE_MOUSE:String = "mouse";
      
      public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String = "touchAndScrollBars";
      
      protected var displayListBypassEnabled:Boolean = true;
      
      protected var layoutViewPort:LayoutViewPort;
      
      protected var _layout:ILayout;
      
      protected var _mxmlContentIsReady:Boolean = false;
      
      protected var _mxmlContent:Array;
      
      public function ScrollContainer()
      {
         var _loc1_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         super();
         this.layoutViewPort = new LayoutViewPort();
         this.viewPort = this.layoutViewPort;
         this.displayListBypassEnabled = _loc1_;
      }
      
      public function get layout() : ILayout
      {
         return this._layout;
      }
      
      public function set layout(param1:ILayout) : void
      {
         if(this._layout == param1)
         {
            return;
         }
         this._layout = param1;
         this.invalidate("layout");
      }
      
      public function get mxmlContent() : Array
      {
         return this._mxmlContent;
      }
      
      public function set mxmlContent(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:DisplayObject = null;
         if(this._mxmlContent == param1)
         {
            return;
         }
         if(this._mxmlContent && this._mxmlContentIsReady)
         {
            _loc3_ = int(this._mxmlContent.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = DisplayObject(this._mxmlContent[_loc4_]);
               this.removeChild(_loc2_,true);
               _loc4_++;
            }
         }
         this._mxmlContent = param1;
         this._mxmlContentIsReady = false;
         this.invalidate("mxmlContent");
      }
      
      override public function set backgroundSkin(param1:DisplayObject) : void
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         super.backgroundSkin = param1;
         this.displayListBypassEnabled = _loc2_;
      }
      
      override public function set backgroundDisabledSkin(param1:DisplayObject) : void
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         super.backgroundDisabledSkin = param1;
         this.displayListBypassEnabled = _loc2_;
      }
      
      override public function get numChildren() : int
      {
         if(!this.displayListBypassEnabled)
         {
            return super.numChildren;
         }
         return DisplayObjectContainer(this.viewPort).numChildren;
      }
      
      override public function getChildByName(param1:String) : DisplayObject
      {
         if(!this.displayListBypassEnabled)
         {
            return super.getChildByName(param1);
         }
         return DisplayObjectContainer(this.viewPort).getChildByName(param1);
      }
      
      override public function getChildAt(param1:int) : DisplayObject
      {
         if(!this.displayListBypassEnabled)
         {
            return super.getChildAt(param1);
         }
         return DisplayObjectContainer(this.viewPort).getChildAt(param1);
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         if(!this.displayListBypassEnabled)
         {
            return super.addChildAt(param1,param2);
         }
         return DisplayObjectContainer(this.viewPort).addChildAt(param1,param2);
      }
      
      override public function removeChildAt(param1:int, param2:Boolean = false) : DisplayObject
      {
         if(!this.displayListBypassEnabled)
         {
            return super.removeChildAt(param1,param2);
         }
         return DisplayObjectContainer(this.viewPort).removeChildAt(param1,param2);
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         if(!this.displayListBypassEnabled)
         {
            return super.getChildIndex(param1);
         }
         return DisplayObjectContainer(this.viewPort).getChildIndex(param1);
      }
      
      override public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         if(!this.displayListBypassEnabled)
         {
            super.setChildIndex(param1,param2);
            return;
         }
         DisplayObjectContainer(this.viewPort).setChildIndex(param1,param2);
      }
      
      override public function swapChildrenAt(param1:int, param2:int) : void
      {
         if(!this.displayListBypassEnabled)
         {
            super.swapChildrenAt(param1,param2);
            return;
         }
         DisplayObjectContainer(this.viewPort).swapChildrenAt(param1,param2);
      }
      
      override public function sortChildren(param1:Function) : void
      {
         if(!this.displayListBypassEnabled)
         {
            super.sortChildren(param1);
            return;
         }
         DisplayObjectContainer(this.viewPort).sortChildren(param1);
      }
      
      override public function dispatchEvent(param1:Event) : void
      {
         var _loc2_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = true;
         super.dispatchEvent(param1);
         this.displayListBypassEnabled = _loc2_;
      }
      
      override public function validate() : void
      {
         var _loc1_:Boolean = this.displayListBypassEnabled;
         this.displayListBypassEnabled = false;
         super.validate();
         this.displayListBypassEnabled = _loc1_;
      }
      
      public function readjustLayout() : void
      {
         this.layoutViewPort.readjustLayout();
         this.invalidate("size");
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.refreshMXMLContent();
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = this.isInvalid("size");
         var _loc4_:Boolean = this.isInvalid("styles");
         var _loc3_:Boolean = this.isInvalid("state");
         var _loc5_:Boolean = this.isInvalid("layout");
         var _loc1_:Boolean = this.isInvalid("mxmlContent");
         if(_loc1_)
         {
            this.refreshMXMLContent();
         }
         if(_loc5_)
         {
            if(this._layout is IVirtualLayout)
            {
               IVirtualLayout(this._layout).useVirtualLayout = false;
            }
            this.layoutViewPort.layout = this._layout;
         }
         super.draw();
      }
      
      protected function refreshMXMLContent() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DisplayObject = null;
         if(!this._mxmlContent || this._mxmlContentIsReady)
         {
            return;
         }
         var _loc2_:int = int(this._mxmlContent.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = DisplayObject(this._mxmlContent[_loc3_]);
            this.addChild(_loc1_);
            _loc3_++;
         }
         this._mxmlContentIsReady = true;
      }
   }
}

