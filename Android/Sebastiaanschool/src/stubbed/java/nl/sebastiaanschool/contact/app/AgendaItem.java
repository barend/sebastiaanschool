/**
 Copyright (c) 2013 Barend Garvelink

 This program code can be used subject to the MIT license. See the LICENSE file for details.
 */
package nl.sebastiaanschool.contact.app;

/**
 * Created by barend on 3-11-13.
 */
public class AgendaItem {
    private static final long NO_END_TIME = Long.MAX_VALUE;
    private final String title;
    private final long startTimestamp;
    private final long endTimestamp;

    public AgendaItem(String title, long startTimestamp) {
        this.title = title;
        this.startTimestamp = startTimestamp;
        this.endTimestamp = NO_END_TIME;
    }

    public AgendaItem(String title, long startTimestamp, long endTimestamp) {
        this.title = title;
        this.startTimestamp = startTimestamp;
        this.endTimestamp = endTimestamp;
    }

    public String getTitle() {
        return title;
    }

    public long getStartTimestamp() {
        return startTimestamp;
    }

    public long getEndTimestamp() {
        return endTimestamp;
    }

    public boolean hasEndDate() {
        return endTimestamp != NO_END_TIME && endTimestamp > startTimestamp;
    }
}