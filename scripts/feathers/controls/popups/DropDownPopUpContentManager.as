package feathers.controls.popups
{
   import feathers.core.IFeathersControl;
   import feathers.core.PopUpManager;
   import feathers.utils.display.getDisplayObjectDepthFromStage;
   import flash.errors.IllegalOperationError;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.events.ResizeEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class DropDownPopUpContentManager extends EventDispatcher implements IPopUpContentManager
   {
      
      protected var content:DisplayObject;
      
      protected var source:DisplayObject;
      
      public function DropDownPopUpContentManager()
      {
         super();
      }
      
      public function open(param1:DisplayObject, param2:DisplayObject) : void
      {
         if(this.content)
         {
            throw new IllegalOperationError("Pop-up content is already defined.");
         }
         this.content = param1;
         this.source = param2;
         PopUpManager.addPopUp(this.content,false,false);
         if(this.content is IFeathersControl)
         {
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
         this.source = null;
         this.dispatchEventWith("close");
      }
      
      public function dispose() : void
      {
         this.close();
      }
      
      protected function layout() : void
      {
         var _loc4_:IFeathersControl = null;
         var _loc3_:Rectangle = this.source.getBounds(Starling.current.stage);
         if(this.source is IFeathersControl)
         {
            IFeathersControl(this.source).validate();
         }
         if(this.content is IFeathersControl)
         {
            _loc4_ = IFeathersControl(this.content);
            _loc4_.minWidth = Math.max(_loc4_.minWidth,this.source.width);
            _loc4_.validate();
         }
         else
         {
            this.content.width = Math.max(this.content.width,this.source.width);
         }
         var _loc2_:Number = Starling.current.stage.stageHeight - this.content.height - (_loc3_.y + _loc3_.height);
         if(_loc2_ >= 0)
         {
            layoutBelow(_loc3_);
            return;
         }
         var _loc1_:Number = _loc3_.y - this.content.height;
         if(_loc1_ >= 0)
         {
            layoutAbove(_loc3_);
            return;
         }
         if(_loc1_ >= _loc2_)
         {
            layoutAbove(_loc3_);
         }
         else
         {
            layoutBelow(_loc3_);
         }
      }
      
      protected function layoutAbove(param1:Rectangle) : void
      {
         var _loc2_:Number = param1.x + (param1.width - this.content.width) / 2;
         var _loc3_:Number = Math.max(0,Math.min(Starling.current.stage.stageWidth - this.content.width,_loc2_));
         this.content.x = _loc3_;
         this.content.y = param1.y - this.content.height;
      }
      
      protected function layoutBelow(param1:Rectangle) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = Math.max(0,Math.min(Starling.current.stage.stageWidth - this.content.width,_loc2_));
         this.content.x = _loc3_;
         this.content.y = param1.y + param1.height;
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
         var _loc3_:DisplayObject = DisplayObject(param1.target);
         if(this.content == _loc3_ || this.content is DisplayObjectContainer && Boolean(DisplayObjectContainer(this.content).contains(_loc3_)))
         {
            return;
         }
         if(this.source == _loc3_ || this.source is DisplayObjectContainer && Boolean(DisplayObjectContainer(this.source).contains(_loc3_)))
         {
            return;
         }
         if(!PopUpManager.isTopLevelPopUp(this.content))
         {
            return;
         }
         var _loc2_:Touch = param1.getTouch(Starling.current.stage,"began");
         if(!_loc2_)
         {
            return;
         }
         this.close();
      }
   }
}

