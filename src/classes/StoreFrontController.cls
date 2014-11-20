public class StoreFrontController 
{
    List<DisplayMerchandise> products;
    Map<ID, DisplayMerchandise> shoppingCart = new Map<ID, DisplayMerchandise>();
    // Action method to handle purchasing process
    public PageReference addToCart() 
    {
        for(DisplayMerchandise p : products) 
        {
            if(0 < p.qtyToBuy) {
                shoppingCart.put(p.id, p);
            }
        }
        return null; // stay on the same page
    }
    
    public String getCartContents() 
    {
        if(0 == shoppingCart.size()) {
        return '(empty)';
        }
        
        String msg = '<ul>\n';
        for(DisplayMerchandise p : shoppingCart.values()) 
        {
            msg += '<li>';
            msg += p.name + ' (' + p.qtyToBuy + ')';
            msg += '</li>\n';
        }
        msg += '</ul>';
        return msg;
    }
    
    public List<DisplayMerchandise> getProducts() 
    {
        if(products == null) 
        {
            products = new List<DisplayMerchandise>();
            for(Merchandise__c item : [
            SELECT Id, Name, Condition__c, Price__c, Quantity__c
            FROM Merchandise__c]) 
            {
                products.add(new DisplayMerchandise(item));
            }
        }
        return products;
    }
    
    
    // Inner class to hold online store details for item
    public class DisplayMerchandise 
    {
        private Merchandise__c merchandise;
        public DisplayMerchandise(Merchandise__c item) {
            this.merchandise = item;
        }
        // Properties for use in the Visualforce view
        public String name {
            get { return merchandise.Name; }
        }
        public String condition{
            get { return merchandise.Condition__c; }
        }
        public Decimal price {
            get { return merchandise.Price__c; }
        }
        public Boolean inStock {
            get { return (0 < merchandise.Quantity__c); }
        }
         public ID id{
            get { return merchandise.id; }
        }
        public Integer qtyToBuy { get; set; }
    }
}