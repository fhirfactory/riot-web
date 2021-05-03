/*
Copyright 2015, 2016 OpenMarket Ltd
Copyright 2019 New Vector Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import React from 'react';
import PropTypes from 'prop-types';
import SdkConfig from 'matrix-react-sdk/src/SdkConfig';

export default class VectorAuthHeaderLogo extends React.PureComponent {
    static replaces = 'AuthHeaderLogo'

    static propTypes = {
        icon: PropTypes.string,
    }

    render() {
        const brandingConfig = SdkConfig.get().branding;
        const loginScreenConfig =  SdkConfig.get().loginScreen;
        const logoSecondaryDescription = SdkConfig.get()['secondary_logo_description'];
        const displaySecondaryVerticalLogo= loginScreenConfig?.displaySecondaryVerticalLogo??false;
        let logoUrl = "themes/element/img/logos/element-logo.svg";
        let logoUrlSecondaryVertical = "themes/element/img/logos/element-logo-secondary-vertical.png";
        if (brandingConfig && brandingConfig.authHeaderLogoUrl) {
            logoUrl = brandingConfig.authHeaderLogoUrl;
        }

        const logoSecondaryVerticalStyle = {
            margin: '25px auto 30px'
        }
        const imgStyle = {
            width:loginScreenConfig?.logo?.img?.width || "100%",
            height:loginScreenConfig?.logo?.img?.height || "100%",
        };
      
        return (
            <div className="mx_AuthHeaderLogo">
                <img style={imgStyle} src={logoUrl} alt="Element" />
                {displaySecondaryVerticalLogo && <img src={logoUrlSecondaryVertical} style={logoSecondaryVerticalStyle} alt={logoSecondaryDescription}/>}
            </div>
        );
    }
}
