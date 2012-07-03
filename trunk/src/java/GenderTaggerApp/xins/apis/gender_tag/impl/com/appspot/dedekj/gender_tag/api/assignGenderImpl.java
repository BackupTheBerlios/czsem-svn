/*
 * $Id$
 */
package com.appspot.dedekj.gender_tag.api;

import czsem.apps.GenderTagger;


/**
 * Implementation of the <code>assignGender</code> function.
 *
 * <p>Description: The simplest variant of the api: single name -> single gender tag
 *
 * @version $Revision$ $Date$
 * @author dedek
 */
public final class assignGenderImpl extends assignGender {

    /**
     * Constructs a new <code>assignGenderImpl</code> instance.
     *
     * @param api
     *    the API to which this function belongs, guaranteed to be not
     *    <code>null</code>.
     */
    public assignGenderImpl(APIImpl api) {
        super(api);
    }

    /**
     * Calls this function. If the function fails, it may throw any kind of
     * exception. All exceptions will be handled by the caller.
     *
     * @param request
     *    the request, never <code>null</code>.
     *
     * @return
     *    the result of the function call, should never be <code>null</code>.
     *
     * @throws Throwable
     *    if anything went wrong.
     */
    public Result call(Request request) throws Throwable {
        SuccessfulResult result = new SuccessfulResult();        
        result.setGender(GenderTagger.getSingleton().classify(request.getInputName(), request.getLanguageTag()));
        return result;
    }
}
