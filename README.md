# dynamicTable
This is a UIViewController subclass that leverages UIStackView to create a dynamic table that allows you to present a drop-down "accessory view" when you select a row.  Animated row insertions and deletions are also included.

In order to create a dynamicCell, either subclass dynamicCell and be sure to override configureBarView and configureAccessoryView (returning nil in the latter if you don't want an accessory view for that cell).

The dynamic table is implemented as a view controller as opposed to a view; this is primarily because the entire class relies on UIStackView's engine, which in turn relies on autolayout.  When trying to set everything up programmatically in a view, the UIStackView didn't function properly.  Being a view controller, however, allows for greater customization of the class, and it can be used as a view if desired.

Note that by default, the barView property is simply a scrollview container for another view and is used to allow swiping to delete a cell.  If trying to add subviews to the barview proprety of a dynamicCell, make sure they are offset by the width of the barView, or add them as subviews to barView's sole existing subview.  If you subclass dynamicCell and override configureBarView you can configure the bar however you like.  Because a dynamicCell includes both a bar view and its accessory view, the most effective to create a dynamic table is by subclassing dynamicCell controlling the view from within the subview.  The method called when the accessory view should hide or show is "tapBar."  If you override this, the dynamicTable will not be able to collapse the cells.  It is not recommended.

