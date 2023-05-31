from zipline.api import order_target, record, symbol
import logging

def initialize(context):
    context.i = 0
    context.asset = symbol('AAPL')
    import julia
    # julia.install() # Configure PyCall to point to this python
    from julia import Main
    context.j = julia.Julia()
    context.jvars = Main
    # Import file
    Main.eval("""include("/root/project/notebooks/DeePC.jl")""")
    Main.eval("x=7")
    print(Main.x)



def handle_data(context, data):
    # data is a BarData Object (https://zipline.ml4trading.io/api-reference.html#data-object)
    # Skip first 300 days to get full windows
    context.i += 1
    if context.i < 300:
        return

    breakpoint()

    # Grab 250 datapoints for price and volume
    y= data.history(context.asset, 'price', bar_count=250, frequency="1d")
    u= data.history(context.asset, 'volume', bar_count=250, frequency="1d")


    # Create a variable x in Julia
    # context.jvars.x=2
    
    # Call custom function from Julia
    # from julia import AlgoSource
    # AlgoSource.greet_your_package_name() 
    
    
    # Compute averages
    # data.history() has to be called with the same params
    # from above and returns a pandas dataframe.
    short_mavg = data.history(context.asset, 'price', bar_count=100, frequency="1d").mean()
    long_mavg = data.history(context.asset, 'price', bar_count=300, frequency="1d").mean()
    # Fields: “price”, “last_traded”, “open”, “high”, “low”, “close”, and “volume”

    # Trading logic (This is the julia bit)
    
    if short_mavg > long_mavg:
        # order_target orders as many shares as needed to
        # achieve the desired number of shares.
        order_target(context.asset, 100)
    elif short_mavg < long_mavg:
        order_target(context.asset, 0)

    # Save values for later inspection
    record(AAPL=data.current(context.asset, 'price'),
           short_mavg=short_mavg,
           long_mavg=long_mavg)