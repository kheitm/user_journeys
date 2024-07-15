
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


def clean_user_journey(df, column_name):
    """
    Replace specific substrings in the specified column of the DataFrame.
    """
    replacements = {
        'Log in': 'Login',
        'Course certificate': 'CourseCertificate',
        'Sign up': 'SignUp',
        'Resources center': 'ResourcesCenter',
        'Career tracks': 'CareerTracks',
        'Upcoming courses': 'UpcomingCourses',
        'Career track certificate': 'CareerTrackCertificate',
        'Success stories': 'SuccessStories',
        'About us': 'AboutUS'     
    }
    
    # Replace the substrings
    df[column_name] = df[column_name].replace(replacements, regex=True)
    
    return df



def process_user_journey(df):
    """
    Process the DataFrame to remove hyphens, replace with spaces, concatenate User Journey values, 
    and create the required columns including 'Pages Visited'.
    """
    # Group by User ID and aggregate the required columns
    grouped = df.groupby('User ID').agg({
        'Subscription Type': 'first',  # Assuming subscription type is the same for each User ID
        'Session ID': 'nunique',  # Count the number of unique sessions per User ID
        'User Journey': lambda x: ' '.join(x.str.replace('-', ' '))
    }).reset_index()

    # Rename columns
    grouped.rename(columns={'Session ID': 'Number of Sessions', 'User Journey': 'Journey'}, inplace=True)

    # Calculate 'Length of Journey', 'Unique Stops', and 'Pages Visited'
    grouped['Length of Journey'] = grouped['Journey'].apply(lambda x: len(x.split()))
    grouped['Number of Pages Visited'] = grouped['Journey'].apply(lambda x: len(set(x.split())))
    grouped['Pages Visited'] = grouped['Journey'].apply(lambda x: ' '.join(set(x.split())))

    # Rearrange columns
    result_df = grouped[['User ID', 'Subscription Type', 'Number of Sessions', 'Length of Journey', 'Number of Pages Visited', 'Pages Visited', 'Journey']]

    return result_df



def extract_substrings_and_counts(df, column_name):
    # Extract all substrings and count their occurrences
    all_substrings = []
    for page_content in df[column_name]:
        substrings = page_content.split()
        all_substrings.extend(substrings)
    
    # Count the occurrences of each substring
    substring_counts = Counter(all_substrings)
    
    # Create a new DataFrame from the counts
    df_new = pd.DataFrame(substring_counts.items(), columns=['Page', 'Frequency'])
    
    return df_new
