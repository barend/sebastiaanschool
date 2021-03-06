/*
 Copyright (c) 2014 Barend Garvelink

 SebastiaanSchool is licensed under a
 Creative Commons Attribution-NonCommercial 3.0 Unported License.

 You should have received a copy of the license along with this
 work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.
 */
package nl.sebastiaanschool.contact.app;

import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.support.v4.view.accessibility.AccessibilityEventCompat;
import android.support.v4.view.accessibility.AccessibilityRecordCompat;
import android.view.MenuItem;
import android.view.Window;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityManager;

import java.util.List;

public class MainActivity extends Activity implements NavigationFragment.Callback, FragmentManager.OnBackStackChangedListener, HorizontalSlidingFragment.Callback, DataLoadingCallback, Handler.Callback {

    private static final int PAGE_NEWSLETTER = 1;
    private static final int PAGE_BULLETIN = 2;
    private static final int MESSAGE_OPEN_PAGE = 1;
    private static final String NAVIGATION_FRAGMENT_TAG = "navFrag";
    private static final long PAGE_OPEN_DELAY = 250L;
    private Handler messageHandler = new Handler(Looper.getMainLooper(), this);
    private AccessibilityManager accessibilityManager;
    private NavigationFragment navigationFragment;
    private boolean detailFragmentVisible;

    @Override
    @SuppressLint("NewApi")
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().requestFeature(Window.FEATURE_ACTION_BAR);
        getWindow().requestFeature(Window.FEATURE_INDETERMINATE_PROGRESS);
        getActionBar().setIcon(R.drawable.ic_sebastiaan_48dp_white);
        if (Build.VERSION.SDK_INT >= 18) {
            getActionBar().setHomeActionContentDescription(R.string.navigation__home_as_up_desc);
        }
        setContentView(R.layout.activity_main);
        getFragmentManager().addOnBackStackChangedListener(this);
        if (savedInstanceState == null) {
            navigationFragment = new NavigationFragment();
            getFragmentManager().beginTransaction().add(R.id.main__content_container, navigationFragment, NAVIGATION_FRAGMENT_TAG).commit();
        } else {
            navigationFragment = (NavigationFragment) getFragmentManager().findFragmentByTag(NAVIGATION_FRAGMENT_TAG);
        }
        accessibilityManager = (AccessibilityManager) getSystemService(ACCESSIBILITY_SERVICE);
        Analytics.trackAppOpened(getIntent());
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        autoNavigateToDetailPageIfNeeded(intent);
    }

    @Override
    protected void onResume() {
        super.onResume();
        autoNavigateToDetailPageIfNeeded(getIntent());
    }

    private void autoNavigateToDetailPageIfNeeded(Intent intent) {
        // If we were launched with OPEN_*, go to the requested page.
        // Use a delay before opening to make the sliding animation look better.
        final String channel = intent.getStringExtra("com.parse.Channel");
        if (SebApp.PUSH_CHANNEL_BULLETIN.equals(channel)) {
            messageHandler.sendMessageDelayed(
                    messageHandler.obtainMessage(MESSAGE_OPEN_PAGE, PAGE_BULLETIN, 0),
                    PAGE_OPEN_DELAY);
        } else if (SebApp.PUSH_CHANNEL_NEWSLETTER.equals(channel)) {
            messageHandler.sendMessageDelayed(
                    messageHandler.obtainMessage(MESSAGE_OPEN_PAGE, PAGE_NEWSLETTER, 0),
                    PAGE_OPEN_DELAY);
        }
    }

    @Override
    public void onItemSelected(int item) {
        switch (item) {
            case ITEM_AGENDA:
                pushFragment(new AgendaFragment());
                break;
            case ITEM_BULLETIN:
                pushFragment(new BulletinFragment());
                break;
            case ITEM_CALL:
                callSebastiaan();
                break;
            case ITEM_HOME:
                GrabBag.openUri(this, getString(R.string.home_url));
                break;
            case ITEM_NEWSLETTER:
                pushFragment(new NewsletterFragment());
                break;
            case ITEM_TEAM:
                pushFragment(new TeamFragment());
                break;
            case ITEM_TWITTER:
                GrabBag.openUri(this, getString(R.string.twitter_url));
                break;
            case ITEM_YURLS:
                GrabBag.openUri(this, getString(R.string.yurls_url));
                break;
        }
    }

    private void callSebastiaan() {
        Analytics.trackEvent("Navigate to dialer");
        final String number = getResources().getString(R.string.call_url);
        final Intent dial = new Intent(Intent.ACTION_DIAL, Uri.parse(number));
        dial.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        List<ResolveInfo> handlers = getPackageManager().queryIntentActivities(dial, 0);
        boolean fail = handlers.isEmpty();
        if (!fail) {
            try {
                startActivity(dial);
            } catch (Exception e) {
                fail = true;
            }
        }
        if (fail) {
            // Unlikely to occur. Tablets generally register their contacts app to handle tel: URI's.
            new AlertDialog.Builder(this)
                    .setCancelable(true)
                    .setMessage(R.string.call_failed_dialog_body)
                    .setNegativeButton(R.string.close_button, null)
                    .show();
        }
    }

    private void pushFragment(HorizontalSlidingFragment fragment) {
        if (detailFragmentVisible)
            return;
        detailFragmentVisible = true;
        String label = getString(fragment.getTitleResId());
        Analytics.trackEvent("Navigate to " + label);
        FragmentTransaction tx = getFragmentManager().beginTransaction();
        fragment.addWithAnimation(tx, R.id.main__content_container, label);
        tx.commit();
    }

    private void popFragment() {
        Analytics.trackEvent("Navigate to home");
        getFragmentManager().popBackStack();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            popFragment();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackStackChanged() {
        detailFragmentVisible = getFragmentManager().getBackStackEntryCount() > 0;
    }

    @Override
    public void onSlidingFragmentBackGesture() {
        popFragment();
    }

    @Override
    public void onSlidingFragmentBeginAnimation(HorizontalSlidingFragment source, boolean willSlideIntoView) {
        ActionBar actionBar = getActionBar();
        actionBar.setHomeButtonEnabled(false);
        actionBar.setDisplayHomeAsUpEnabled(false);
        actionBar.setSubtitle(null);
        if (!willSlideIntoView) {
            // Before the detail fragment begins moving out of screen, make the underlying navigation fragment visible.
            navigationFragment.setVisible(true);
        }
    }

    @Override
    public void onSlidingFragmentEndAnimation(HorizontalSlidingFragment source, boolean didSlideIntoView) {
        ActionBar actionBar = getActionBar();
        actionBar.setHomeButtonEnabled(didSlideIntoView);
        actionBar.setDisplayHomeAsUpEnabled(didSlideIntoView);
        if (didSlideIntoView) {
            // After the detail fragment has appeared on top of the navigation fragment, hide the latter to reduce GPU overdraw.
            navigationFragment.setVisible(false);
            final int titleResId = source.getTitleResId();
            if (titleResId != 0) {
                final String title = getString(titleResId);
                actionBar.setSubtitle(title);
                announce(getString(source.getAnnouncementResId(), title));
            }
        } else {
            announce(getString(R.string.accessibility__announce_return_home));
        }
    }

    /**
     * AccessibilityService voodoo lifted from http://stackoverflow.com/a/18502185/49489.
     */
    private void announce(final CharSequence announcement) {
        if (!accessibilityManager.isEnabled()) {
            return;
        }
        final int eventType = Build.VERSION.SDK_INT < 16
                ? AccessibilityEvent.TYPE_VIEW_FOCUSED
                : AccessibilityEventCompat.TYPE_ANNOUNCEMENT;
        AccessibilityEvent event = AccessibilityEvent.obtain(eventType);
        event.setEventTime(System.currentTimeMillis());
        event.setEnabled(true);
        event.setClassName(MainActivity.class.getName());
        event.setPackageName(getPackageName());
        event.getText().add(announcement);
        final AccessibilityRecordCompat record = AccessibilityEventCompat.asRecord(event);
        record.setSource(this.findViewById(android.R.id.content));
        accessibilityManager.sendAccessibilityEvent(event);
    }

    @Override
    public void onStartLoading() {
        this.setProgressBarIndeterminateVisibility(true);
    }

    @Override
    public void onStopLoading(Exception e) {
        // TODO report exceptions to analytics
        this.setProgressBarIndeterminateVisibility(false);
    }

    @Override
    public boolean handleMessage(Message msg) {
        if (msg.what == MESSAGE_OPEN_PAGE) {
            if (detailFragmentVisible) {
                popFragment();
                messageHandler.sendMessageDelayed(messageHandler.obtainMessage(MESSAGE_OPEN_PAGE, msg.arg1, 0), PAGE_OPEN_DELAY);
            } else {
                if (msg.arg1 == PAGE_BULLETIN) {
                    pushFragment(new BulletinFragment());
                } else {
                    pushFragment(new NewsletterFragment());
                }
            }
            return true;
        }
        return false;
    }
}
