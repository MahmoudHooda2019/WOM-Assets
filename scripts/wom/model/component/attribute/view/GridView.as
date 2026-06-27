package wom.model.component.attribute.view
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.dto.Point3;
   import peak.cuckoo.game.dto.WeightNode;
   import wom.model.component.WomGameRoot;
   import wom.model.game.helper.RowColumnPair;
   
   public class GridView extends BaseView
   {
      
      private var gridSize:RowColumnPair;
      
      private var isoProjection:IsoProjection;
      
      private var columns:int;
      
      private var rows:int;
      
      private var gridBitmapData:BitmapData;
      
      private var fScore:Array;
      
      private var grid:Array;
      
      private var frameDraw:Boolean = true;
      
      private var gridDraw:Boolean = false;
      
      private var weightDraw:Boolean = false;
      
      private var pathDraw:Boolean = false;
      
      private var wayPointBitmapData:BitmapData;
      
      public function GridView(param1:RowColumnPair)
      {
         super(1);
         this.gridSize = param1;
      }
      
      override public function init() : void
      {
         super.init();
         isoProjection = (owner.root as WomGameRoot).projection as IsoProjection;
         columns = gridSize.numberOfColumns;
         rows = gridSize.numberOfRows;
         grid = (owner.root as WomGameRoot).weightGrid.grid;
      }
      
      public function draw() : void
      {
      }
      
      private function drawFrame(param1:Graphics) : void
      {
         param1.lineStyle(1,16777215,1);
         param1.moveTo(rows * isoProjection.pitchX / 2,0);
         param1.lineTo(0,rows * isoProjection.pitchY / 2);
         param1.lineTo(columns * isoProjection.pitchX / 2,(rows + columns) * isoProjection.pitchY / 2);
         param1.lineTo((rows + columns) * isoProjection.pitchX / 2,columns * isoProjection.pitchY / 2);
         param1.lineTo(rows * isoProjection.pitchX / 2,0);
      }
      
      public function drawGrid(param1:Graphics) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = gridSize.numberOfColumns;
         var _loc4_:int = gridSize.numberOfRows;
         param1.lineStyle(1,16777215,0.4);
         _loc3_ = 1;
         while(_loc3_ < _loc4_)
         {
            if(_loc3_ % 5 == 0)
            {
               param1.lineStyle(1,4473924,0.4);
            }
            else
            {
               param1.lineStyle(1,16777215,0.4);
            }
            if(_loc3_ == _loc4_ / 2)
            {
               param1.lineStyle(1,16711680,0.4);
            }
            param1.moveTo((_loc4_ - _loc3_) * isoProjection.pitchX / 2,_loc3_ * isoProjection.pitchY / 2);
            param1.lineTo((_loc4_ - _loc3_ + _loc2_) * isoProjection.pitchX / 2,(_loc2_ + _loc3_) * isoProjection.pitchY / 2);
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ < _loc2_)
         {
            if(_loc3_ % 5 == 0)
            {
               param1.lineStyle(1,4473924,0.4);
            }
            else
            {
               param1.lineStyle(1,16777215,0.4);
            }
            if(_loc3_ == _loc2_ / 2)
            {
               param1.lineStyle(1,16711680,0.4);
            }
            param1.moveTo((_loc4_ + _loc3_) * isoProjection.pitchX / 2,_loc3_ * isoProjection.pitchY / 2);
            param1.lineTo(_loc3_ * isoProjection.pitchX / 2,(_loc4_ + _loc3_) * isoProjection.pitchY / 2);
            _loc3_++;
         }
      }
      
      private function drawPath(param1:Graphics) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Number = Math.random() * 10 * 256 / 55;
         var _loc2_:Number = _loc3_ * 256 * 256;
         _loc2_ += 256 * (256 - _loc3_);
         param1.lineStyle(1,_loc2_,1);
         var _loc4_:int = gridSize.numberOfColumns;
         var _loc8_:int = gridSize.numberOfRows;
         for(var _loc5_ in fScore)
         {
            _loc7_ = 0;
            _loc6_ = 0;
            _loc7_ = _loc6_ = 0;
            _loc7_ = _loc7_ + (_loc4_ + _loc8_) * isoProjection.pitchX / 4;
            _loc6_ += (_loc4_ + _loc8_) * isoProjection.pitchY / 4;
            _loc7_ += grid[_loc5_].x * isoProjection.pitchX / 2 - grid[_loc5_].y * isoProjection.pitchX / 2;
            _loc6_ += grid[_loc5_].y * isoProjection.pitchY / 2 + grid[_loc5_].x * isoProjection.pitchY / 2;
            param1.beginFill(16777215,1);
            param1.moveTo(_loc7_,_loc6_ + 1);
            param1.lineTo(_loc7_ - 2,_loc6_ + 2.5);
            param1.lineTo(_loc7_,_loc6_ + 4);
            param1.lineTo(_loc7_ + 2,_loc6_ + 2.5);
            param1.lineTo(_loc7_,_loc6_ + 1);
            param1.endFill();
         }
      }
      
      private function drawWeight(param1:Graphics) : void
      {
         var _loc5_:WeightNode = null;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:int = gridSize.numberOfColumns;
         var _loc9_:int = gridSize.numberOfRows;
         param1.lineStyle(1,0,0);
         for each(var _loc6_ in grid)
         {
            _loc5_ = _loc6_ as WeightNode;
            _loc8_ = 0;
            _loc7_ = 0;
            _loc8_ = _loc7_ = 0;
            _loc8_ = _loc8_ + (_loc4_ + _loc9_) * isoProjection.pitchX / 4;
            _loc7_ += (_loc4_ + _loc9_) * isoProjection.pitchY / 4;
            _loc8_ += _loc5_.x * isoProjection.pitchX / 2 - _loc5_.y * isoProjection.pitchX / 2;
            _loc7_ += _loc5_.y * isoProjection.pitchY / 2 + _loc5_.x * isoProjection.pitchY / 2;
            _loc3_ = _loc5_.weight * 256 / 55;
            _loc2_ = _loc3_ * 256 * 256;
            _loc2_ += 256 * (256 - _loc3_);
            param1.beginFill(_loc2_,1);
            param1.moveTo(_loc8_,_loc7_ + 1);
            param1.lineTo(_loc8_ - 2,_loc7_ + 2.5);
            param1.lineTo(_loc8_,_loc7_ + 4);
            param1.lineTo(_loc8_ + 2,_loc7_ + 2.5);
            param1.lineTo(_loc8_,_loc7_ + 1);
            param1.endFill();
         }
      }
      
      public function changeWeightGrid(param1:Boolean) : void
      {
         weightDraw = param1;
         draw();
      }
      
      public function changePathFindGrid(param1:Array, param2:Boolean) : void
      {
         if(pathDraw == param2 && !param2)
         {
            return;
         }
         this.fScore = param1;
         pathDraw = param2;
         draw();
      }
      
      public function changeFrameDraw(param1:Boolean) : void
      {
         frameDraw = param1;
         draw();
      }
      
      public function changeGridDraw(param1:Boolean) : void
      {
         gridDraw = param1;
         draw();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(gridBitmapData)
         {
            gridBitmapData.dispose();
         }
      }
      
      public function clear() : void
      {
         if(gridBitmapData)
         {
            gridBitmapData.dispose();
         }
         gridBitmapData = new BitmapData(isoProjection.pitchX / 2 * (columns + rows),isoProjection.pitchY / 2 * (columns + rows),true,0);
         fScore = null;
         wayPointBitmapData = new BitmapData(gridBitmapData.width,gridBitmapData.height,true,0);
         draw();
      }
      
      public function addWaypoint(param1:Vector.<Point3>, param2:Point3) : void
      {
         if(!wayPointBitmapData)
         {
            wayPointBitmapData = new BitmapData(gridBitmapData.width,gridBitmapData.height,true,0);
         }
         var _loc7_:Shape = new Shape();
         var _loc6_:Graphics = _loc7_.graphics;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         _loc8_ = (columns + rows) * isoProjection.pitchX / 4;
         _loc5_ = (columns + rows) * isoProjection.pitchY / 4;
         _loc8_ += param2.x * isoProjection.pitchX / 2 - param2.y * isoProjection.pitchX / 2;
         _loc5_ += param2.y * isoProjection.pitchY / 2 + param2.x * isoProjection.pitchY / 2;
         _loc6_.lineStyle(1,16711680,1);
         for each(var _loc3_ in param1)
         {
            _loc9_ = _loc8_;
            _loc4_ = _loc5_;
            _loc8_ = (columns + rows) * isoProjection.pitchX / 4;
            _loc5_ = (columns + rows) * isoProjection.pitchY / 4;
            _loc8_ += _loc3_.x * isoProjection.pitchX / 2 - _loc3_.y * isoProjection.pitchX / 2;
            _loc5_ += _loc3_.y * isoProjection.pitchY / 2 + _loc3_.x * isoProjection.pitchY / 2;
            _loc6_.moveTo(_loc9_,_loc4_);
            _loc6_.lineTo(_loc8_,_loc5_);
         }
         wayPointBitmapData.draw(_loc7_,new Matrix());
         _bitmapData.copyPixels(wayPointBitmapData,wayPointBitmapData.rect,new Point(),null,null,true);
      }
   }
}

