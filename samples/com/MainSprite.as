package com
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.extensions.display.SpriteMask;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainSprite extends Sprite
	{
		private var sprite:SpriteMask = new SpriteMask();
		private var spriteMask:SpriteMask = new SpriteMask();

		public function MainSprite()
		{
			var quad:Quad = new Quad(300, 200, 0x0000FF);
			spriteMask.addChild(quad);
			
			var mask:Quad = new Quad(100, 100, 0x000000);
			spriteMask.mask = mask;
			
			sprite.addChild( spriteMask );		
			this.addChild( sprite );
			sprite.addEventListener(TouchEvent.TOUCH, onTouchEvent);
		}
		
		private function onTouchEvent(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			if( ! touch ) return;
			if (touch.phase == TouchPhase.BEGAN)
			{
				trace( sprite.width, sprite.height, sprite.contentWidth, sprite.contentHeight, spriteMask.width, spriteMask.height, spriteMask.contentWidth, spriteMask.contentHeight );
			}
		}
	}
}