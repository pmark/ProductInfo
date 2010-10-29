//
//  ProductInfo.m
//  ProductInfo
//
//  Created by P. Mark Anderson on 10/26/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import "ProductInfo.h"
#import "AIXMLSerialization.h"

// See http://upcdatabase.com

#define UPC_DATABASE_RPC_KEY @"YOUR RPC KEY HERE"

@implementation ProductInfo

@synthesize delegate;

- (id) decodeXML:(NSString *)xml error:(NSError **)error 
{
    NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
    NSError *parseError = nil;
    NSXMLDocument *doc = [[[NSXMLDocument alloc] initWithData:data options:NSXMLDocumentTidyXML error:&parseError] autorelease];
    
    if (parseError != nil) 
    {        
        if (error != nil)
        {
            *error = parseError;
        }
        
        return nil;
    }
    
    return [doc toDictionary];
}

- (NSString *) parseProductDescription:(id)data
{
    @try 
    {
        data = [data objectForKey:@"methodResponse"];
        data = [data objectForKey:@"params"];
        data = [data objectForKey:@"param"];
        data = [data objectForKey:@"value"];
        data = [data objectForKey:@"struct"];
        data = [data objectForKey:@"member"];
        
        for (NSDictionary *member in data)
        {
            NSString *name = [member objectForKey:@"name"];
            if (name && [name isEqualToString:@"description"])
            {
                return [[member objectForKey:@"value"] objectForKey:@"string"];
            }
        }
    }
    @catch (NSException *e) 
    {
        NSLog(@"Error parsing XML: %@", [e reason]);
    }
    
    return nil;
}

- (void) fetchProductInfo:(NSString *)ean
{
    NSString *rpcKey = UPC_DATABASE_RPC_KEY;
    
    NSURL *URL = [NSURL URLWithString: @"http://www.upcdatabase.com/xmlrpc"];  
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL:URL];
    XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];
    
    NSArray *params = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        rpcKey, @"rpc_key",
                        ean, @"ean",
                        nil],
                       nil];
    
    [request setMethod:@"lookup" withParameters:params];
    
    //NSLog(@"Request body: %@", [request body]);
    
    [manager spawnConnectionWithXMLRPCRequest:request delegate:self];
    
    [request release];
}

#pragma mark -

- (void) request:(XMLRPCRequest *)request didReceiveResponse:(XMLRPCResponse *)response
{
	//NSLog(@"XMLRPC response: %@", [response body]);
    
    id parsed = [self decodeXML:[response body] error:nil];
	//NSLog(@"XMLRPC parsed: %@", parsed);
    
    NSString *description = [self parseProductDescription:parsed];
    [self.delegate productDescriptionWasFetched:description];
}

- (void) request:(XMLRPCRequest *)request didFailWithError:(NSError *)error
{
	NSLog(@"XMLRPC error: %@", [error localizedDescription]);
}

- (BOOL) request:(XMLRPCRequest *)request canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
	return YES;
}

- (void) request:(XMLRPCRequest *)request didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

- (void) request:(XMLRPCRequest *)request didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

@end
