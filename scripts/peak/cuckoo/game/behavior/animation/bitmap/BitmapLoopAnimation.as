package peak.cuckoo.game.behavior.animation.bitmap
{
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.animation.LoopAnimation;
   
   public class BitmapLoopAnimation extends LoopAnimation
   {
      
      public static var dirtyMap:Dictionary = new Dictionary();
      
      protected var frames:Vector.<BitmapData>;
      
      private var collideBitmapData:BitmapData;
      
      public function BitmapLoopAnimation(param1:int, param2:int)
      {
         super();
         this.fpsChangeRate = param1;
         this.frameWidth = param2;
      }
      
      override public function update() : void
      {
         frameCounter += sync.precise;
         frameNum = int(frameCounter / fpsChangeRate) % frameTotal;
         view._bitmapData = frames[frameNum];
      }
      
      override public function prepareFrames(param1:BitmapData, param2:AnimationAssetView) : void
      {
         var _loc4_:* = 0;
         var _loc3_:Array = null;
         view = param2;
         frameHeight = param1.height;
         this.frameTotal = param1.width / frameWidth;
         frameCounter = 0;
         if(frameTotal > 0 && frameHeight > 0 && frameWidth > 0)
         {
            if(dirtyMap[param1] == null)
            {
               frames = new Vector.<BitmapData>();
               _loc4_ = 0;
               while(_loc4_ < frameTotal)
               {
                  frames[_loc4_] = new BitmapData(frameWidth,frameHeight,true,0);
                  frames[_loc4_].copyPixels(param1,new Rectangle(frameWidth * _loc4_,0,frameWidth,frameHeight),new Point(),null,null,true);
                  _loc4_++;
               }
               dirtyMap[param1] = frames;
            }
            else
            {
               frames = new Vector.<BitmapData>();
               _loc4_ = 0;
               while(_loc4_ < frameTotal)
               {
                  frames[_loc4_] = dirtyMap[param1][_loc4_];
                  _loc4_++;
               }
            }
            frameCounter = frameNum = Math.random() * 100 % frameTotal;
            view.bitmapData = frames[frameNum];
            if(requested)
            {
               enable();
            }
            collideBitmapData = frames[0].clone();
            _loc3_ = [];
            _loc3_ = _loc3_.concat([1,0,0,0,0]);
            _loc3_ = _loc3_.concat([0,0,0,0,0]);
            _loc3_ = _loc3_.concat([0,0,0,0,0]);
            _loc3_ = _loc3_.concat([0,0,0,0.6,0]);
            collideBitmapData.applyFilter(frames[0],frames[0].rect,new Point(0,0),new ColorMatrixFilter(_loc3_));
            prepared = true;
         }
      }
      
      override public function selectEnableDisableBitmap(param1:Boolean) : void
      {
         if(view)
         {
            if(param1)
            {
               view.bitmapData = collideBitmapData;
               disable();
            }
            else
            {
               view.bitmapData = frames[0];
               enable();
            }
         }
      }
   }
}

