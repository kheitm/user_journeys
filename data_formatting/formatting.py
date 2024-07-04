
import pandas as pd

def replace_values_containing_string(df, column_name, target_string, replacement_value):
    """
    Replace values in the specified column where the value contains the target string.
    
    Parameters:
    df (pd.DataFrame): The input DataFrame.
    column_name (str): The name of the column to check.
    target_string (str): The string to search for in the column values.
    replacement_value (str): The value to replace the matched values with.
    """
    df[column_name] = df[column_name].apply(lambda x: replacement_value if target_string in x else x)
    return df



def simplify_checkout_value(df, column_name):
    """
    Replace strings in a DataFrame column that start with 'Checkout' with 'Checkout'.
    
    Parameters:
    df: The input DataFrame.
    column_name (str): The name of the column where replacements should occur.
    
    """
    # Define the lambda function to replace strings starting with 'Checkout'
    replace_checkout = lambda x: 'Checkout' if x.startswith('Checkout') else x
    
    # Apply the lambda function to the specified column
    df[column_name] = df[column_name].apply(replace_checkout)
    
    return df



def remove_post_checkout(df, user_id_col, value_col):
    """
    Removes session rows for each user id after 'Checkout' 
    
    Parameters:
    df: The input DataFrame.
    column_name (str): The user_id column
    value_col (str): The column where the value condition is assessed

    """
    def truncate_group(group):
        if 'Checkout' in group[value_col].values:
            checkout_index = group[group[value_col] == 'Checkout'].index[0]
            group = group.loc[:checkout_index]
        return group

    # Apply the truncate_group function to each group
    processed_df = df.groupby(user_id_col).apply(truncate_group).reset_index(drop=True)
    
  return processed_df
