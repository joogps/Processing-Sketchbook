/**
 * This is a spin-off of
 *
 * GetWindowLocation (v2.1)
 * by  Quark (2016-Jul-28)
 * mod GoToLoop
 *
 * forum.Processing.org/two/discussion/17675/
 * how-to-get-surface-window-x-and-y-coordinates#Item_12
 */

final int[] xy = new int[2];
float[][] pos = new float[10][2];

void setup() {
  size(300, 200);

  for (int i = 0; i < pos.length; i++) {
    pos[i][0] = random(0, displayWidth);
    pos[i][1] = random(0, displayHeight);
  }

  surface.setResizable(true);
}

void draw() {
  getWindowLocation(this, xy);

  xy[0] = xy[0]+displayWidth/2;
  xy[1] = xy[1]+displayHeight/2;

  background(0);
  fill(255);

  for (int i = 0; i < pos.length; i++) {
    ellipse(pos[i][0] - xy[0], pos[i][1] - xy[1], 50, 50);
  }
}

static final int[] getWindowLocation(final PApplet pa, int... xy) {
  if (xy == null || xy.length < 2)  xy = new int[2];

  final Object surf = pa.getSurface().getNative();
  final PGraphics canvas = pa.getGraphics();

  if (canvas.isGL()) {
    xy[0] = ((com.jogamp.nativewindow.NativeWindow) surf).getX();
    xy[1] = ((com.jogamp.nativewindow.NativeWindow) surf).getY();
  } else if (canvas instanceof processing.awt.PGraphicsJava2D) {
    final java.awt.Component f =
      ((processing.awt.PSurfaceAWT.SmoothCanvas) surf).getFrame();

    xy[0] = f.getX();
    xy[1] = f.getY();
  } else try {
    final java.lang.reflect.Method getStage =
      surf.getClass().getDeclaredMethod("getStage");

    getStage.setAccessible(true);

    final Object stage = getStage.invoke(surf);
    final Class<?> st = stage.getClass();

    final java.lang.reflect.Method getX = st.getMethod("getX");
    final java.lang.reflect.Method getY = st.getMethod("getY");

    xy[0] = ((Number) getX.invoke(stage)).intValue();
    xy[1] = ((Number) getY.invoke(stage)).intValue();
  }
  catch (final ReflectiveOperationException e) {
    System.err.println(e);
  }

  return xy;
}
