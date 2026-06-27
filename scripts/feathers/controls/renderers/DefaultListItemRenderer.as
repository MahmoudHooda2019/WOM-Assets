package feathers.controls.renderers
{
   import feathers.controls.List;
   
   public class DefaultListItemRenderer extends BaseDefaultItemRenderer implements IListItemRenderer
   {
      
      protected var _index:int = -1;
      
      public function DefaultListItemRenderer()
      {
         super();
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
      
      public function get owner() : List
      {
         return List(this._owner);
      }
      
      public function set owner(param1:List) : void
      {
         var _loc2_:List = null;
         if(this._owner == param1)
         {
            return;
         }
         if(this._owner)
         {
            this._owner.removeEventListener("scrollStart",owner_scrollStartHandler);
            this._owner.removeEventListener("scrollComplete",owner_scrollCompleteHandler);
         }
         this._owner = param1;
         if(this._owner)
         {
            _loc2_ = List(this._owner);
            this.isSelectableWithoutToggle = _loc2_.isSelectable;
            this.isToggle = _loc2_.allowMultipleSelection;
            this._owner.addEventListener("scrollStart",owner_scrollStartHandler);
            this._owner.addEventListener("scrollComplete",owner_scrollCompleteHandler);
         }
         this.invalidate("data");
      }
      
      override public function dispose() : void
      {
         this.owner = null;
         super.dispose();
      }
   }
}

