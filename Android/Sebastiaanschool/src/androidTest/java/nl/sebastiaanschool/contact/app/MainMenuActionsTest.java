package nl.sebastiaanschool.contact.app;

import android.app.Instrumentation;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.PatternMatcher;
import android.test.ActivityInstrumentationTestCase2;
import android.test.FlakyTest;
import android.test.suitebuilder.annotation.MediumTest;

import static com.google.android.apps.common.testing.ui.espresso.Espresso.onView;
import static com.google.android.apps.common.testing.ui.espresso.action.ViewActions.click;
import static com.google.android.apps.common.testing.ui.espresso.assertion.ViewAssertions.matches;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.isDisplayed;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withContentDescription;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withId;
import static com.google.android.apps.common.testing.ui.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.not;

@MediumTest
public class MainMenuActionsTest extends ActivityInstrumentationTestCase2<MainActivity> {

    public MainMenuActionsTest() {
        super(MainActivity.class);
    }

    int actionBarSubtitleViewId;

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        // Resolve android.R.id.action_bar_subtitle dynamically, because it's hidden from the SDK JAR.
        actionBarSubtitleViewId = getActivity().getResources().getIdentifier("action_bar_subtitle", "id", "android");
    }

    public void testHomepageClick() throws Exception {
        Instrumentation.ActivityMonitor monitor = registerMonitor(Intent.ACTION_VIEW, "http", "www.sebastiaanschool.nl");
        onView(withId(R.id.navigate__home))
                .check(matches(withContentDescription("Homepage")))
                .perform(click());
        getInstrumentation().checkMonitorHit(monitor, 1);
    }

    public void testTwitterClick() throws Exception {
        Instrumentation.ActivityMonitor monitor = registerMonitor(Intent.ACTION_VIEW, "http", "www.twitter.com", "/KBSebastiaan");
        onView(withId(R.id.navigate__twitter)).perform(click());
        getInstrumentation().checkMonitorHit(monitor, 1);
    }

    public void testYulsClick() throws Exception {
        Instrumentation.ActivityMonitor monitor = registerMonitor(Intent.ACTION_VIEW, "http", "sebastiaan.yurls.net");
        onView(withId(R.id.navigate__yurl)).perform(click());
        getInstrumentation().checkMonitorHit(monitor, 1);
    }

    @FlakyTest(tolerance = 3)
    public void testAgendaClick() {
        onView(withId(R.id.navigate__agenda)).perform(click());
        waitForSlidingAnimationToComplete();
        onView(withId(actionBarSubtitleViewId)).check(matches(allOf(withText("Agenda"), isDisplayed())));

        onView(withId(android.R.id.home)).perform(click());
        waitForSlidingAnimationToComplete();
        onView(withId(actionBarSubtitleViewId)).check(matches(not(isDisplayed())));
    }

    @FlakyTest(tolerance = 3)
    public void testTeamClick() {
        onView(withId(R.id.navigate__team)).perform(click());
        waitForSlidingAnimationToComplete();
        onView(withId(actionBarSubtitleViewId)).check(matches(allOf(withText("Team"), isDisplayed())));

        onView(withId(android.R.id.home)).perform(click());
        waitForSlidingAnimationToComplete();
        onView(withId(actionBarSubtitleViewId)).check(matches(not(isDisplayed())));
    }

    public void testCallClick() throws Exception {
        Instrumentation.ActivityMonitor monitor = registerMonitor(Intent.ACTION_DIAL, "tel");
        onView(withId(R.id.navigate__call)).perform(click());
        getInstrumentation().checkMonitorHit(monitor, 1);
    }

    @FlakyTest(tolerance = 3)
    public void testNewsletterClick() {
        onView(withId(R.id.navigate__newsletter)).perform(click());
        waitForSlidingAnimationToComplete();
        onView(withId(actionBarSubtitleViewId)).check(matches(allOf(withText("Newsletter"), isDisplayed())));

        onView(withId(android.R.id.home)).perform(click());
        waitForSlidingAnimationToComplete();
        onView(withId(actionBarSubtitleViewId)).check(matches(not(isDisplayed())));
    }

    @FlakyTest(tolerance = 3)
    public void testBulletinClick() {
        onView(withId(R.id.navigate__bulletin)).perform(click());
        waitForSlidingAnimationToComplete();
        onView(withId(actionBarSubtitleViewId)).check(matches(allOf(withText("Bulletin"), isDisplayed())));

        onView(withId(android.R.id.home)).perform(click());
        waitForSlidingAnimationToComplete();
        onView(withId(actionBarSubtitleViewId)).check(matches(not(isDisplayed())));
    }

    private void waitForSlidingAnimationToComplete() {
        try {
            Thread.sleep(600L);
        } catch (InterruptedException e) {
            // Ignored
        }
    }

    private Instrumentation.ActivityMonitor registerMonitor(String action, String scheme) {
        return registerMonitor(action, scheme, null, null);
    }

    private Instrumentation.ActivityMonitor registerMonitor(String action, String scheme, String authority) {
        return registerMonitor(action, scheme, authority, null);
    }

    private Instrumentation.ActivityMonitor registerMonitor(String action, String scheme, String authority, String path) {
        IntentFilter filter = new IntentFilter(action);
        filter.addDataScheme(scheme);
        if (authority != null) {
            filter.addDataAuthority(authority, null);
        }
        if (path != null) {
            filter.addDataPath(path, PatternMatcher.PATTERN_LITERAL);
        }
        return getInstrumentation().addMonitor(filter, null, true);
    }
}