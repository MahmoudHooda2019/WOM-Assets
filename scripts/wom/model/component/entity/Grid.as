package wom.model.component.entity
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.attribute.view.GridView;
   import wom.model.game.helper.RowColumnPair;
   
   public class Grid extends GameSprite
   {
      
      private var gridView:GridView;
      
      public function Grid(param1:RowColumnPair)
      {
         super();
         componentManager.add(position = new Position(new Point3(0,0)));
         componentManager.add(view = new GridView(param1));
         componentManager.add(new BaseProjection());
      }
      
      override public function init() : void
      {
         super.init();
         gridView = view as GridView;
      }
      
      public function changePathFindGrid(param1:Array, param2:Boolean) : void
      {
         gridView.changePathFindGrid(param1,param2);
      }
      
      public function changeWeightGrid(param1:Boolean) : void
      {
         gridView.changeWeightGrid(param1);
      }
      
      public function enableGridDraw(param1:Boolean) : void
      {
         gridView.changeGridDraw(param1);
      }
      
      public function enableFrameDraw(param1:Boolean) : void
      {
         gridView.changeFrameDraw(param1);
      }
      
      public function clear() : void
      {
         gridView.clear();
      }
      
      public function addWaypoint(param1:Vector.<Point3>, param2:Point3) : void
      {
         gridView.addWaypoint(param1,param2);
      }
      
      public function addView() : void
      {
         root.layers[view.layerId].add(this);
         this.validator.add(this);
      }
      
      public function removeView() : void
      {
         root.layers[view.layerId].remove(this);
      }
   }
}

