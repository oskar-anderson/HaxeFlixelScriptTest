package;

import scripts.ScriptTest;
import flixel.FlxG;
import flixel.FlxState;

// lime test html5 -D hscriptPos
class PlayState extends FlxState
{
	var useSeparateClassForScripting = true;  // both work

	override public function create():Void
	{
		super.create();
		// FlxG.fixedTimestep = true;
		FlxG.updateFramerate = 30;
		FlxG.drawFramerate = 30;
		FlxG.mouse.useSystemCursor = true;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.Q) {

			if (useSeparateClassForScripting) {
				ScriptTest.RunScript();
			}
			else {
				var script = "
					var sample = 'My name is <strong>::name::</strong>, <em>::age::</em> years old';
					var user = {name: 'Mark', age: 30};
					var template = new haxe.Template(sample);
					var output = template.execute(user);
					trace(output);

					function main() {
						// var err = 0;;
						// var angles = [1.57, 3.14];
						sum = 0;
						for( a in angles )
							sum += Math.cos(a);
						return sum;
					}

					function main2() {
						return 'asd';
					}

					main();
				";
				var parser = new hscript.Parser();
				var program = parser.parseString(script);
				var interp = new hscript.Interp();
				interp.variables.set("Math", Math); // share the Math class
				interp.variables.set("angles", [0,1,2,3]); // set the angles list
				trace( interp.execute(program) );

				var sample = 'Compiled version. My name is <strong>::name::</strong>, <em>::age::</em> years old';
				var user = {name: 'Mark', age: 30};
				var template = new haxe.Template(sample);
				var output = template.execute(user);
				trace(output);
			}
		}
	}
}
