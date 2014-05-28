cordova.define("GAWhisper", function(require, exports, module) {
    
    var exec = require('cordova/exec');

    function GAWhisper() { }

    /**
     * Used to initialize whisper with google analytics tracking id
     * @param  {function} success 
     * @param  {function} fail    
     * @param  {string} id - id of the google analytics account
     * @param  {string} period - set Google Analytics dispatch interval  
     */
    GAWhisper.prototype.init = function(success, fail, id, period) {
        return exec(success, fail, 'GAWhisper', 'init', [id, period]);
    };

    /**
     * Used to log events
     * @param  {function} success 
     * @param  {function} fail    
     * @param  {object} params - params of the request 
     *                           @category - The event category
     *                           @eventAction - The event action
     *                           @eventLabel - Optional.The event label
     *                           @eventValue - Optional.The event value
     */
    GAWhisper.prototype.trackEvent = function(success, fail, params ){
        //required params
        var category = params.category;
        var eventAction = params.eventAction;

        var eventLabel = params.eventLabel;
        var eventValue = params.eventValue;

        return exec(success, fail, 'GAWhisper', 'trackEvent', [category, eventAction, eventLabel, eventValue]);
    };

    /**
     * Method is used to track transaction.
     * @param  {function} success 
     * @param  {function} fail    
     * @param  {object} params - params of the request 
     *                           @transactionId - A unique ID representing the transaction. This ID should not collide with other transaction IDs.
     *                           @affilation - An entity with which the transaction should be affiliated (e.g. a particular store)
     *                           @revenue - The total revenue of a transaction, including tax and shipping
     *                           @tax - The total tax for a transaction
     *                           @shipping - The total cost of shipping for a transaction
     *                           @currency_code - Optional.The local currency of a transaction.
     */
    GAWhisper.prototype.trackTransaction = function(success, fail, params) {

        return exec(success, fail, 'GAWhisper', 'trackItem', [ params.transactionId, params.affilation,
            params.revenue, params.tax, params.shipping, params.currency_code]);
    };

    /**
     * Tracking item for specific transaction
     * @param  {function} success 
     * @param  {function} fail    
     * @param  {object} params - params of the request 
     *                           @transactionId - A unique ID representing the transaction. This ID should not collide with other transaction IDs.
     *                           @name - The name of the product
     *                           @SKU - The SKU of a product
     *                           @category - Optional. A category to which the product belongs
     *                           @price - The price of a product
     *                           @quantity - The quantity of a product
     *                           @currency_code - Optional.The local currency of a transaction.
     */
    GAWhisper.prototype.trackItem = function(success, fail, transactionId, affilation, revenue, tax, shipping, cost, segment, category) {
        return exec(success, fail, 'GAWhisper', 'trackItem', [trackingNumber, orderId, source, feauter_id, feature_name, cost, segment, category]);
    };


    /**
     * Used to track current page
     * @param  {function} success 
     * @param  {function} fail  
     * @param  {string} screenName name of the screen
     */
    GAWhisper.prototype.trackView = function(success, fail, screenName) {
        return exec(success, fail, 'GAWhisper', 'trackView', [pageURL]);
    };

    /**
     * Custom dimensions enable the association of metadata with hits, users, and sessions in Google Analytics, 
     * while custom metrics enable you to create and increment your own metrics in Google Analytics.
     * @param  {function} success 
     * @param  {function} fail  
     * @param  {number} index   index of the value
     * @param  {string} value   of the custom element
     */
    GAWhisper.prototype.setCustomValue = function(success, fail, index, value) {
        return exec(success, fail, 'GAWhisper', 'setCustomValue', [index, value]);
    };
    
    /**
     * Exit Whisper
     * @param  {function} success 
     * @param  {function} fail    
     */
    GAWhisper.prototype.exit = function(success, fail) {
        return exec(success, fail, 'GAWhisper', 'exitGAWhisper', []);
    };
 
    module.exports = new GAWhisper();

});