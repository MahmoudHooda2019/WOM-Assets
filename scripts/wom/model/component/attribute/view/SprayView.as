package wom.model.component.attribute.view
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.projection.IsoOffsetProjection;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.BaseView;
   
   public class SprayView extends BaseView
   {
      
      public static const margin:int = 25;
      
      public var collidedBitmapData:BitmapData;
      
      public var originalBitmapData:BitmapData;
      
      public var factorX:Number;
      
      public var factorY:Number;
      
      public var radius:Number;
      
      private var _deploymentMode:int;
      
      private var glowFilter:GlowFilter;
      
      private var _salvoType:int;
      
      public function SprayView(param1:int, param2:int, param3:int = -1)
      {
         super(2);
         radius = param1 / 2;
         this._deploymentMode = param2;
         _salvoType = param3;
      }
      
      override public function init() : void
      {
         super.init();
         var _loc1_:IsoProjection = owner.root.projection as IsoProjection;
         this.factorX = _loc1_.pitchX * radius * Math.sqrt(2);
         this.factorY = _loc1_.pitchY * radius * Math.sqrt(2);
         if(_bitmapData)
         {
            _bitmapData.dispose();
         }
         if(originalBitmapData)
         {
            originalBitmapData.dispose();
         }
         if(collidedBitmapData)
         {
            collidedBitmapData.dispose();
         }
         prepareBitmap();
         var _loc2_:IsoOffsetProjection = owner.componentManager["BaseProjection"] as IsoOffsetProjection;
         _loc2_.offset.x = factorX / -2;
         _loc2_.offset.y = factorY / -2;
         (owner as GameSprite).position.refreshPosition();
      }
      
      protected function prepareBitmap() : void
      {
         var _loc4_:Sprite = null;
         var _loc1_:Matrix = null;
         var _loc3_:Shape = null;
         var _loc2_:Graphics = null;
         if(_deploymentMode == 2)
         {
            glowFilter = new GlowFilter(14606079,1,2,2,1,3);
            bitmapData = new BitmapData(factorX + 2 * 25,factorY + 2 * 25,true,0);
            switch(_salvoType - 1)
            {
               case 0:
                  _loc4_ = new LumberDeployCircle();
                  break;
               case 1:
                  _loc4_ = new StoneDeployCircle();
                  break;
               case 2:
                  _loc4_ = new MightDeployCircle();
                  break;
               case 3:
                  _loc4_ = new AcidRainDeployCircle();
                  break;
               case 4:
                  _loc4_ = new AcidRainDeployCircle();
                  break;
               case 5:
                  _loc4_ = new AcidRainDeployCircle();
                  break;
               default:
                  return;
            }
            _loc4_.width = factorX;
            _loc4_.height = factorX;
            _loc4_.filters = [glowFilter];
            _loc1_ = new Matrix();
            _loc1_.scale(factorX / 400,factorY / 400);
            _loc1_.translate(25,25);
            _bitmapData.draw(_loc4_,_loc1_,null,null,null,true);
            originalBitmapData = _bitmapData;
            collidedBitmapData = _bitmapData.clone();
            collidedBitmapData.colorTransform(collidedBitmapData.rect,new ColorTransform(1,0,0,0.6));
            factorX += 2 * 25;
            factorY += 2 * 25;
         }
         else
         {
            _loc3_ = new Shape();
            _loc2_ = _loc3_.graphics;
            _loc2_.lineStyle(1,16777215,1);
            _loc2_.beginFill(16777215,0.6);
            _loc2_.drawEllipse(0,0,factorX,factorY);
            _loc2_.endFill();
            bitmapData = new BitmapData(factorX + 2,factorY + 2,true,0);
            _bitmapData.draw(_loc3_,new Matrix());
            originalBitmapData = _bitmapData;
            collidedBitmapData = _bitmapData.clone();
            collidedBitmapData.colorTransform(collidedBitmapData.rect,new ColorTransform(1,0,0,0.6));
         }
      }
      
      public function setSize(param1:int) : void
      {
         radius = param1 / 2;
         init();
      }
      
      public function selectCollide(param1:Boolean) : void
      {
         if(param1)
         {
            bitmapData = collidedBitmapData;
         }
         else
         {
            bitmapData = originalBitmapData;
         }
      }
      
      public function set deploymentMode(param1:int) : void
      {
         _deploymentMode = param1;
      }
      
      public function set salvoType(param1:int) : void
      {
         _salvoType = param1;
      }
   }
}

