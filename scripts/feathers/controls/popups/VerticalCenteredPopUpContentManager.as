package feathers.controls.popups
{
   import feathers.core.IFeathersControl;
   import feathers.core.PopUpManager;
   import feathers.utils.display.getDisplayObjectDepthFromStage;
   import flash.errors.IllegalOperationError;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Stage;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.events.ResizeEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class VerticalCenteredPopUpContentManager extends EventDispatcher implements IPopUpContentManager
   {
      
      private static const HELPER_POINT:Point = new Point();
      
      public var marginTop:Number = 0;
      
      public var marginRight:Number = 0;
      
      public var marginBottom:Number = 0;
      
      public var marginLeft:Number = 0;
      
      protected var content:DisplayObject;
      
      protected var touchPointID:int = -1;
      
      public function VerticalCenteredPopUpContentManager()
      {
         super();
      }
      
      public function get margin() : Number
      {
         return this.marginTop;
      }
      
      public function set margin(param1:Number) : void
      {
         this.marginTop = 0;
         this.marginRight = 0;
         this.marginBottom = 0;
         this.marginLeft = 0;
      }
      
      public function open(param1:DisplayObject, param2:DisplayObject) : void
      {
         var _loc4_:IFeathersControl = null;
         if(this.content)
         {
            throw new IllegalOperationError("Pop-up content is already defined.");
         }
         this.content = param1;
         PopUpManager.addPopUp(this.content,true,false);
         if(this.content is IFeathersControl)
         {
            _loc4_ = IFeathersControl(this.content);
            this.content.addEventListener("resize",content_resizeHandler);
         }
         this.layout();
         Starling.current.stage.addEventListener("touch",stage_touchHandler);
         Starling.current.stage.addEventListener("resize",stage_resizeHandler);
         var _loc3_:int = -getDisplayObjectDepthFromStage(this.content);
         Starling.current.nativeStage.addEventListener("keyDown",nativeStage_keyDownHandler,false,_loc3_,true);
      }
      
      public function close() : void
      {
         if(!this.content)
         {
            return;
         }
         Starling.current.stage.removeEventListener("touch",stage_touchHandler);
         Starling.current.stage.removeEventListener("resize",stage_resizeHandler);
         Starling.current.nativeStage.removeEventListener("keyDown",nativeStage_keyDownHandler);
         if(this.content is IFeathersControl)
         {
            this.content.removeEventListener("resize",content_resizeHandler);
         }
         PopUpManager.removePopUp(this.content);
         this.content = null;
         this.dispatchEventWith("close");
      }
      
      public function dispose() : void
      {
         this.close();
      }
      
      protected function layout() : void
      {
         var _loc3_:IFeathersControl = null;
         var _loc2_:Number = Math.min(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight) - this.marginLeft - this.marginRight;
         var _loc1_:Number = Starling.current.stage.stageHeight - this.marginTop - this.marginBottom;
         if(this.content is IFeathersControl)
         {
            _loc3_ = IFeathersControl(this.content);
            _loc3_.minWidth = _loc3_.maxWidth = _loc2_;
            _loc3_.maxHeight = _loc1_;
            _loc3_.validate();
         }
         else
         {
            if(this.content.width > _loc2_)
            {
               this.content.width = _loc2_;
            }
            if(this.content.height > _loc1_)
            {
               this.content.height = _loc1_;
            }
         }
         this.content.x = (Starling.current.stage.stageWidth - this.content.width) / 2;
         this.content.y = (Starling.current.stage.stageHeight - this.content.height) / 2;
      }
      
      protected function content_resizeHandler(param1:Event) : void
      {
         this.layout();
      }
      
      protected function nativeStage_keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.isDefaultPrevented())
         {
            return;
         }
         if(param1.keyCode != 16777238 && param1.keyCode != 27)
         {
            return;
         }
         param1.preventDefault();
         this.close();
      }
      
      protected function stage_resizeHandler(param1:ResizeEvent) : void
      {
         this.layout();
      }
      
      protected function stage_touchHandler(param1:TouchEvent) : void
      {
         var _loc3_:Touch = null;
         var _loc2_:DisplayObject = null;
         var _loc4_:Boolean = false;
         if(!PopUpManager.isTopLevelPopUp(this.content))
         {
            return;
         }
         var _loc5_:Stage = Starling.current.stage;
         if(this.touchPointID >= 0)
         {
            _loc3_ = param1.getTouch(_loc5_,"ended",this.touchPointID);
            if(!_loc3_)
            {
               return;
            }
            _loc3_.getLocation(_loc5_,HELPER_POINT);
            _loc2_ = _loc5_.hitTest(HELPER_POINT,true);
            _loc4_ = false;
            if(this.content is DisplayObjectContainer)
            {
               _loc4_ = Boolean(DisplayObjectContainer(this.content).contains(_loc2_));
            }
            else
            {
               _loc4_ = this.content == _loc2_;
            }
            if(!_loc4_)
            {
               this.touchPointID = -1;
               this.close();
            }
         }
         else
         {
            _loc3_ = param1.getTouch(_loc5_,"began");
            if(!_loc3_)
            {
               return;
            }
            _loc3_.getLocation(_loc5_,HELPER_POINT);
            _loc2_ = _loc5_.hitTest(HELPER_POINT,true);
            _loc4_ = false;
            if(this.content is DisplayObjectContainer)
            {
               _loc4_ = Boolean(DisplayObjectContainer(this.content).contains(_loc2_));
            }
            else
            {
               _loc4_ = this.content == _loc2_;
            }
            if(_loc4_)
            {
               return;
            }
            this.touchPointID = _loc3_.id;
         }
      }
   }
}

