package starling.extensions.display
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	/**
	 * The scroll rectangle bounds of the display object. The display object is cropped to the size defined by the rectangle, and it scrolls within the rectangle when you change the x and y properties.
	 */
	public class SpriteMask extends Sprite
	{
		public function SpriteMask()
		{
			super();
		}
		
		/**
		 * @private
		 */
		override public function get width():Number
		{
			if( ! this.mask ) return measure( this ).width;
			return this.mask.width;
		}
		
		/**
		 * @private
		 */
		override public function get height():Number
		{
			if( ! this.mask ) return measure( this ).height;
			return this.mask.height;
		}
		
		/**
		 * The height of the viewport's content.
		 */
		public function get contentWidth():Number
		{
			return measure( this ).width;
		}
		
		/**
		 * The width of the viewport's content.
		 */
		public function get contentHeight():Number
		{
			return measure( this ).height;
		}
		
		private var rect:Rectangle;
		
		private function measure(container:DisplayObjectContainer):Rectangle
		{
			if( container == this ) this.rect = new Rectangle();
			if( container.numChildren == 0 ) return this.rect;
			for( var i:int = 0; i < container.numChildren; i++ )
			{
				var displayObject:DisplayObject = container.getChildAt(i);
				var rect:Rectangle = getRect( displayObject );
				this.rect = this.rect.union( rect );
				if( ! ( displayObject is DisplayObjectContainer ) ) continue; // is a Quad
				if( displayObject.mask ) continue;
				measure( displayObject as DisplayObjectContainer );
			}
			if( container == this )
			{
				this.rect.width *= this.scaleX;
				this.rect.height *= this.scaleY;
			}
			return this.rect;
		}
		
		private function getRect(displayObject:DisplayObject):Rectangle
		{
			var rect:Rectangle= new Rectangle();
			var point:Point = new Point( displayObject.x, displayObject.y );
			point = displayObject.parent.localToGlobal( point );
			point = this.globalToLocal( point );
			rect.x = point.x;
			rect.y = point.y;
			point = new Point( displayObject.x + displayObject.width, displayObject.y + displayObject.height );
			point = displayObject.parent.localToGlobal( point );
			point = this.globalToLocal( point );
			rect.width = point.x - rect.x;
			rect.height = point.y - rect.y;
			return rect;
		}
	}
}
