package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(frameRate = "60", backgroundColor = "0xEEEEEE")]
	public class particle_step3 extends Sprite
	{
		private const size:int = 3;
		private var particleList:Array = [];

		/** コンストラクター */
		public function particle_step3()
		{
			// 時間経過
			this.addEventListener(Event.ENTER_FRAME, handleTick);
		}

		private function handleTick(event):void
		{
			// パーティクルを発生
			emitParticles();
			// パーティクルを更新
			updateParticles();
		}
		
		/** パーティクルを発生させます */
		private function emitParticles():void {
			// for文を作成 (上限数はパーティクルの個数)
			for (var i:int = 0; i < 4; i++)
			{
				// 赤い丸を作成
				var particle:MovieClip = new MovieClip();
				particle.graphics.beginFill(0xFF0000);
				particle.graphics.drawCircle(0, 0, size);
				this.addChild(particle);
				
				// パーティクルの発生場所
				particle.x = stage.mouseX;
				particle.y = stage.mouseY;
				
				// 動的にプロパティーを追加します。
				// 速度
				particle.vx = 10 * (Math.random() - 0.5);
				particle.vy = 10 * (Math.random() - 0.5);
				// 寿命
				particle.life = 50;
				
				// 配列に保存
				particleList.push(particle);
			}
		}
		
		/** パーティクルを更新します */
		private  function updateParticles():void {
			for (var i:int = 0; i < particleList.length; i++)
			{
				// i番目の要素を変数に代入
				var particle:MovieClip = particleList[i];
				// 重力
				particle.vy += 1;
				// 摩擦
				particle.vx *= 0.95;
				particle.vy *= 0.95;
				// 反映
				particle.x += particle.vx;
				particle.y += particle.vy;
				if (particle.y > stage.stageHeight - size)
				{ // 地面
					particle.y = stage.stageHeight - size; // 行き過ぎ補正
					particle.vy *= -1; // Y軸の速度を反転
				}
				
				// 寿命を減らす
				particle.life -= 1;
				// 寿命の判定
				if (particle.life <= 0) {
					// ステージから削除
					this.removeChild(particle);
					// 配列からも削除
					particleList.splice(i, 1);
				}
			}
		}
	}
}
