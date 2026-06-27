package feathers.controls
{
   import feathers.core.IFeathersControl;
   
   public interface IScrollBar extends IFeathersControl
   {
      
      function get minimum() : Number;
      
      function set minimum(param1:Number) : void;
      
      function get maximum() : Number;
      
      function set maximum(param1:Number) : void;
      
      function get value() : Number;
      
      function set value(param1:Number) : void;
      
      function get step() : Number;
      
      function set step(param1:Number) : void;
      
      function get page() : Number;
      
      function set page(param1:Number) : void;
   }
}

