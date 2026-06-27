package peak.cuckoo.game.behavior.animation.uv
{
   import flash.display.BitmapData;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.animation.StateDirectionAnimation;
   import peak.cuckoo.game.behavior.render.gpu.GpuRender;
   import peak.resource.atlas.BlockReference;
   
   public class UVStateDirectionAnimation extends StateDirectionAnimation
   {
      
      private var states:Vector.<Vector.<AnimationPart>>;
      
      private var frames:Vector.<BlockReference>;
      
      private var lastFrameNum:int = -1;
      
      private var render:GpuRender;
      
      public function UVStateDirectionAnimation(param1:Array, param2:int, param3:int)
      {
         super(param1,param2,param3);
         this.stateFramesTotal = param2;
         this.directionTotal = param3;
      }
      
      override public function get typeId() : String
      {
         return "Animation";
      }
      
      override public function init() : void
      {
         super.init();
         render = owner.root.render as GpuRender;
      }
      
      override public function update() : void
      {
         frameCounter += sync.precise;
         frameNum = int(frameCounter / fpsChangeRate) % frameTotal;
      }
      
      override public function prepareFrames(param1:BitmapData, param2:AnimationAssetView) : void
      {
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         view = param2;
         this.stateTotal = stateMap.length;
         this.frameWidth = param1.width / directionTotal;
         this.frameHeight = param1.height / stateFramesTotal;
         frameCounter = 0;
         if(stateTotal > 0 && directionTotal > 0 && frameHeight > 0 && frameWidth > 0)
         {
            states = new Vector.<Vector.<AnimationPart>>();
            _loc5_ = 0;
            while(_loc5_ < directionTotal)
            {
               states[_loc5_] = new Vector.<AnimationPart>();
               _loc3_ = 0;
               _loc3_ = 0;
               while(_loc3_ < stateTotal)
               {
                  states[_loc5_][_loc3_] = new AnimationPart();
                  states[_loc5_][_loc3_].frames = new Vector.<BlockReference>();
                  frameTotal = stateMap[_loc3_].length;
                  _loc4_ = 0;
                  _loc4_ = 0;
                  while(_loc4_ < frameTotal)
                  {
                     _loc4_++;
                  }
                  states[_loc5_][_loc3_].totalFrame = frameTotal;
                  states[_loc5_][_loc3_].fpsChangeRate = stateMap[_loc3_].fpsChangeRate;
                  _loc3_++;
               }
               _loc5_++;
            }
         }
         frameNum = 0;
         frames = states[_direction][_state].frames;
         frameTotal = states[_direction][_state].totalFrame;
         fpsChangeRate = states[_direction][_state].fpsChangeRate;
         prepared = true;
         view.gpuImage.assetReady();
         ownerSprite.bounds.init();
         ownerSprite.position.refreshPosition();
         enable();
      }
      
      override public function set direction(param1:uint) : void
      {
         try
         {
            _direction = param1;
            frames = states[_direction][_state].frames;
            frameTotal = states[_direction][_state].totalFrame;
            if(frameNum >= frameTotal)
            {
               frameNum = 0;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function set state(param1:uint) : void
      {
         try
         {
            _state = param1;
            frames = states[_direction][_state].frames;
            frameTotal = states[_direction][_state].totalFrame;
            fpsChangeRate = states[_direction][_state].fpsChangeRate * _modifier;
            if(frameNum >= frameTotal)
            {
               frameNum = 0;
            }
            frameCounter = Math.random() * frameTotal * fpsChangeRate;
         }
         catch(e:Error)
         {
         }
      }
      
      override public function get modifier() : Number
      {
         return super.modifier;
      }
      
      override public function set modifier(param1:Number) : void
      {
         super.modifier = param1;
         try
         {
            fpsChangeRate = states[_direction][_state].fpsChangeRate * _modifier;
         }
         catch(e:Error)
         {
         }
      }
   }
}

import peak.resource.atlas.BlockReference;

class AnimationPart
{
   
   public var frames:Vector.<BlockReference>;
   
   public var fpsChangeRate:uint;
   
   public var totalFrame:uint;
   
   public function AnimationPart()
   {
      super();
   }
}
