package feathers.core
{
   import flash.utils.Dictionary;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   import starling.display.Stage;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.events.ResizeEvent;
   
   public class PopUpManager
   {
      
      protected static var ignoreRemoval:Boolean = false;
      
      protected static var _root:DisplayObjectContainer;
      
      private static const POPUP_TO_OVERLAY:Dictionary = new Dictionary(true);
      
      private static const POPUP_TO_FOCUS_MANAGER:Dictionary = new Dictionary(true);
      
      private static const CENTERED_POPUPS:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      public static var overlayFactory:Function = defaultOverlayFactory;
      
      protected static var popUps:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      public function PopUpManager()
      {
         super();
      }
      
      public static function defaultOverlayFactory() : DisplayObject
      {
         var _loc1_:Quad = new Quad(100,100,0);
         _loc1_.alpha = 0;
         return _loc1_;
      }
      
      public static function get root() : DisplayObjectContainer
      {
         return _root;
      }
      
      public static function set root(param1:DisplayObjectContainer) : void
      {
         var _loc6_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc2_:DisplayObject = null;
         if(_root == param1)
         {
            return;
         }
         var _loc7_:int = int(popUps.length);
         var _loc5_:Boolean = ignoreRemoval;
         ignoreRemoval = true;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc3_ = popUps[_loc6_];
            _loc2_ = DisplayObject(POPUP_TO_OVERLAY[_loc6_]);
            _loc3_.removeFromParent(false);
            if(_loc2_)
            {
               _loc2_.removeFromParent(false);
            }
            _loc6_++;
         }
         ignoreRemoval = _loc5_;
         _root = param1;
         var _loc4_:DisplayObjectContainer = _root ? _root : Starling.current.stage;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc3_ = popUps[_loc6_];
            _loc2_ = DisplayObject(POPUP_TO_OVERLAY[_loc6_]);
            if(_loc2_)
            {
               _loc4_.addChild(_loc2_);
            }
            _loc4_.addChild(_loc3_);
            _loc6_++;
         }
      }
      
      public static function addPopUp(param1:DisplayObject, param2:Boolean = true, param3:Boolean = true, param4:Function = null) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:DisplayObjectContainer = _root ? _root : Starling.current.stage;
         if(param2)
         {
            if(param4 == null)
            {
               param4 = overlayFactory;
            }
            if(param4 == null)
            {
               param4 = defaultOverlayFactory;
            }
            _loc5_ = param4();
            _loc5_.width = _loc6_.stage.stageWidth;
            _loc5_.height = _loc6_.stage.stageHeight;
            _loc6_.addChild(_loc5_);
            POPUP_TO_OVERLAY[param1] = _loc5_;
         }
         popUps.push(param1);
         _loc6_.addChild(param1);
         param1.addEventListener("removedFromStage",popUp_removedFromStageHandler);
         if(popUps.length == 1)
         {
            _loc6_.stage.addEventListener("resize",stage_resizeHandler);
         }
         if(FocusManager.isEnabled && param1 is DisplayObjectContainer)
         {
            POPUP_TO_FOCUS_MANAGER[param1] = new FocusManager(DisplayObjectContainer(param1));
         }
         if(param3)
         {
            CENTERED_POPUPS.push(param1);
            centerPopUp(param1);
         }
      }
      
      public static function removePopUp(param1:DisplayObject, param2:Boolean = false) : void
      {
         var _loc3_:int = popUps.indexOf(param1);
         if(_loc3_ < 0)
         {
            throw new ArgumentError("Display object is not a pop-up.");
         }
         param1.removeFromParent(param2);
      }
      
      public static function isPopUp(param1:DisplayObject) : Boolean
      {
         return popUps.indexOf(param1) >= 0;
      }
      
      public static function isTopLevelPopUp(param1:DisplayObject) : Boolean
      {
         return popUps.indexOf(param1) == popUps.length - 1;
      }
      
      public static function centerPopUp(param1:DisplayObject) : void
      {
         var _loc2_:Stage = Starling.current.stage;
         if(param1 is IFeathersControl)
         {
            IFeathersControl(param1).validate();
         }
         param1.x = (_loc2_.stageWidth - param1.width) / 2;
         param1.y = (_loc2_.stageHeight - param1.height) / 2;
      }
      
      protected static function popUp_removedFromStageHandler(param1:Event) : void
      {
         var popUp:DisplayObject;
         var index:int;
         var overlay:DisplayObject;
         var focusManager:IFocusManager;
         var event:Event = param1;
         if(ignoreRemoval)
         {
            return;
         }
         popUp = DisplayObject(event.currentTarget);
         popUp.removeEventListener("removedFromStage",popUp_removedFromStageHandler);
         index = popUps.indexOf(popUp);
         popUps.splice(index,1);
         overlay = DisplayObject(POPUP_TO_OVERLAY[popUp]);
         if(overlay)
         {
            Starling.current.stage.addEventListener("enterFrame",function(param1:EnterFrameEvent):void
            {
               param1.currentTarget.removeEventListener(param1.type,arguments.callee);
               overlay.removeFromParent(true);
               delete POPUP_TO_OVERLAY[popUp];
            });
         }
         focusManager = POPUP_TO_FOCUS_MANAGER[popUp];
         if(focusManager)
         {
            delete POPUP_TO_FOCUS_MANAGER[popUp];
            FocusManager.removeFocusManager(focusManager);
         }
         index = CENTERED_POPUPS.indexOf(popUp);
         if(index >= 0)
         {
            CENTERED_POPUPS.splice(index,1);
         }
         if(popUps.length == 0)
         {
            Starling.current.stage.removeEventListener("resize",stage_resizeHandler);
         }
      }
      
      protected static function stage_resizeHandler(param1:ResizeEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc2_:DisplayObject = null;
         var _loc4_:Stage = Starling.current.stage;
         var _loc6_:int = int(popUps.length);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = popUps[_loc5_];
            _loc2_ = DisplayObject(POPUP_TO_OVERLAY[_loc3_]);
            if(_loc2_)
            {
               _loc2_.width = _loc4_.stageWidth;
               _loc2_.height = _loc4_.stageHeight;
            }
            _loc5_++;
         }
         _loc6_ = int(CENTERED_POPUPS.length);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = CENTERED_POPUPS[_loc5_];
            centerPopUp(_loc3_);
            _loc5_++;
         }
      }
   }
}

